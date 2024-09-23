import 'package:crew_app/components/helper_functions.dart';
import 'package:crew_app/models/wallet_job_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class WalletController extends BaseController {
  final RxList<WalletJob> allJobs = <WalletJob>[].obs;
  final pageSize = 10;
  final Rx<WalletModel?> wallet = Rx<WalletModel?>(null);
  final PagingController<int, WalletJob> pagingController = PagingController(firstPageKey: 1);
  final Rx<DateTimeRange?> dateRange = Rx<DateTimeRange?>(null);

  final RxBool isSheetOpen = false.obs;
  final RxBool hasInitialJobs = false.obs;
  final RxBool isFiltering = false.obs;

  final provider = Get.find<WalletProvider>();

  bool get shouldShowBlueOutline => isSheetOpen.value || dateRange.value != null;

  @override
  void onInit() {
    super.onInit();
    _fetchPage(1);

    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      showLoader();
      final result = await provider.getWallet(
        page: pageKey,
        limit: pageSize,
        sortField: 'MoveDate',
        startDate: dateRange.value?.start,
        endDate: dateRange.value?.end,
      );

      if (result != null) {
        wallet.value = result;
        final newJobs = result.completedJobs;

        if (pageKey == 1) {
          allJobs.assignAll(newJobs);
        } else {
          allJobs.addAll(newJobs);
        }

        hasInitialJobs.value = allJobs.isNotEmpty;

        final isLastPage = newJobs.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newJobs);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newJobs, nextPageKey);
        }
      }
    } catch (e, stack) {
      Logger().e('Error fetching wallet page: $e\n$stack');
      pagingController.error = e;
    } finally {
      hideLoader();
      isFiltering.value = false;
    }
  }

  Future<DateTimeRange?> openDateRangePicker(Widget picker) async {
    isSheetOpen.value = true;
    final result = await Get.bottomSheet<DateTimeRange?>(
      picker,
      isScrollControlled: true,
      isDismissible: false,
    );
    isSheetOpen.value = false;
    return result;
  }

  Future<void> updateDateRange(DateTimeRange? newRange) async {
    Logger().d(newRange);
    if (newRange == null) {
      isFiltering.value = false;
      dateRange.value = null;
      onRefresh();
    }else {
      dateRange.value = newRange;
      isFiltering.value = true;
      await onRefresh();
    }
  }

  String get dateRangeText {
    if (dateRange.value == null) {
      return 'All Time';
    } else {
      final start = formatDateAndTime(dateRange.value!.start);
      final end = formatDateAndTime(dateRange.value!.end);
      return '$start - $end';
    }
  }
}
