import 'dart:async';

import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Timer? _debounce;
  final Rx<Map<String, List<Map<String, String>>>> filterOptions =
      Rx<Map<String, List<Map<String, String>>>>({});
  final Rx<DateTimeRange?> dateRange = Rx<DateTimeRange?>(null);
  final RxBool isCustomDateFilterApplied = false.obs;
  final RxBool isCallButtonActive = false.obs;
  final provider = Get.find<DashboardProvider>();
  final searchController = TextEditingController();
  final int _pageSize = 10;
  final PagingController<int, CompleteJob> todayPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CompleteJob> upcomingPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CompleteJob> completedPagingController =
      PagingController(firstPageKey: 1);

  final tabs = ['TODAY', 'UPCOMING', 'COMPLETED'];
  final RxMap<String, bool> selectedFilters = <String, bool>{}.obs;

  final RxString searchQuery = ''.obs;
  final RxBool isAnyFilterActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      refreshCurrentTab();
    });

    todayPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, 'TODAY', todayPagingController);
    });
    upcomingPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, 'UPCOMING', upcomingPagingController);
    });
    completedPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, 'COMPLETED', completedPagingController);
    });

    fetchFilterOptions();
  }

  Future<void> _fetchPage(int pageKey, String tab,
      PagingController<int, CompleteJob> pagingController) async {
    showLoader();
    final result = await provider.notifications(
      page: pageKey,
      limit: _pageSize,
      type: tab,
      jobTypeIds: getAppliedFilters(),
      creationStart: isCustomDateFilterApplied.value && dateRange.value != null
          ? dateRange.value!.start.toIso8601String().split('T')[0]
          : null,
      creationEnd: isCustomDateFilterApplied.value && dateRange.value != null
          ? dateRange.value!.end.toIso8601String().split('T')[0]
          : null,
      searchKeyword: searchQuery.value.isNotEmpty ? searchQuery.value : null,
    );

    hideLoader();

    if (result != null) {
      final List<CompleteJob> jobs = result;
      final bool isLastPage = jobs.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(jobs);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(jobs, nextPageKey);
      }
    } else {
      pagingController.error = 'Failed to fetch jobs';
    }
  }

  Future<void> launchMapWithWaypoints(CompleteJob job) async {
    // Ensure pickup and dropoff coordinates are available
    if ((job.pickupFullAddress?.isNotEmpty ?? false) &&
        (job.dropoffFullAddress?.isNotEmpty ?? false)) {
      // Get the available maps
      final availableMaps = await MapLauncher.installedMaps;
      final Position? currentLocation = await getCurrentCoordinates();
      if (currentLocation == null) return;

      // Build the waypoint string for Google Maps
      String waypointsString = '';
      List<Waypoint> waypoints = [
        Waypoint(job.pickupFullAddress![0].coordinates!.lat!,
            job.pickupFullAddress![0].coordinates!.lng!)
      ];
      if (job.pickupFullAddress!.isNotEmpty) {
        waypointsString = job.pickupFullAddress![0].waypoints.map((waypoint) {
          waypoints.add(Waypoint(waypoint.latlng!.lat!, waypoint.latlng!.lng!,
              waypoint.description));
          "${waypoint.latlng!.lat},${waypoint.latlng!.lng}";
        }).join('|'); // Google Maps separates waypoints with '|'
      }
      if (job.dropoffFullAddress!.isNotEmpty) {
        waypointsString = job.dropoffFullAddress![0].waypoints.map((waypoint) {
          waypoints.add(Waypoint(waypoint.latlng!.lat!, waypoint.latlng!.lng!,
              waypoint.description));
          return "${waypoint.latlng!.lat},${waypoint.latlng!.lng}";
        }).join('|'); // Google Maps separates waypoints with '|'
      }

      Logger().d(waypointsString);

      // Build the Google Maps URL
      final googleMapsUrl =
          'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}'
          '&destination=${job.dropoffFullAddress![0].coordinates!.lat},${job.dropoffFullAddress![0].coordinates!.lng}'
          '&waypoints=$waypointsString';

      if (availableMaps.any((map) => map.mapName == 'Google Maps')) {
        // Launch Google Maps with waypoints if available
        await MapLauncher.showDirections(
          mapType: MapType.google,
          origin: Coords(
            currentLocation.latitude,
            currentLocation.longitude,
          ),
          destination: Coords(
            job.dropoffFullAddress![0].coordinates!.lat!,
            job.dropoffFullAddress![0].coordinates!.lng!,
          ),
          waypoints: waypoints,
          originTitle: job.pickupAddress ?? "Pickup Location",
          destinationTitle: job.dropoffAddress ?? "Dropoff Location",
        );
      } else {
        // Fallback: Open the URL in a web browser if Google Maps is not available
        final uri = Uri.parse(googleMapsUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          print("Unable to launch maps");
        }
      }
    } else {
      print("Coordinates not available for pickup or drop off");
    }
  }

  Future<void> onRefresh(
      PagingController<int, CompleteJob> pagingController) async {
    await _fetchPage(1, tabs[tabController.index], pagingController);
    pagingController.refresh();
  }

  void openFilterBottomSheet(Widget widget) {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      widget,
    );
  }

  void updateFilterActiveStatus() {
    isAnyFilterActive.value =
        selectedFilters.values.any((isSelected) => isSelected) ||
            isCustomDateFilterApplied.value ||
            searchQuery.value.isNotEmpty;
  }

  void refreshCurrentTab() {
    switch (tabController.index) {
      case 0:
        todayPagingController.refresh();
        break;
      case 1:
        upcomingPagingController.refresh();
        break;
      case 2:
        completedPagingController.refresh();
        break;
    }
  }

  Future<void> fetchFilterOptions() async {
    try {
      final options = await provider.filterOption();
      filterOptions.value = options;
      initializeSelectedFilters();
    } catch (error) {
      Logger().e('Error fetching filter options: $error');
    }
  }

  void initializeSelectedFilters() {
    filterOptions.value['jobTypes']?.forEach((option) {
      selectedFilters[option['value'] ?? ''] = false;
    });
  }

  void setCustomDateRange(DateTimeRange? range) {
    if (range != null) {
      dateRange.value = range;
      isCustomDateFilterApplied.value = true;
    } else {
      dateRange.value = null;
      isCustomDateFilterApplied.value = false;
    }
    updateFilterActiveStatus();
    refreshCurrentTab();
  }

  void clearAllFilters() {
    selectedFilters.clear();
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setSearchQuery(query);
    });
  }

  List<String> getAppliedFilters() {
    return selectedFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  void applyFilter() {
    Get.back();
    updateFilterActiveStatus();
    refreshCurrentTab();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    refreshCurrentTab();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return const Color(0xffE1AD01);
      case 'completed':
        return const Color(0xff27794D);
      default:
        return Colors.transparent;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    _debounce?.cancel();
    todayPagingController.dispose();
    upcomingPagingController.dispose();
    completedPagingController.dispose();
    super.dispose();
  }
}
