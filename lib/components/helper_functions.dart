import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

IconData getIconFromExtension(String fileName) {
  final ext = fileName
      .split('.')
      .last;
  switch (ext) {
    case 'jpg':
      return TablerIcons.file_type_jpg;
    case 'pdf':
      return TablerIcons.file_type_pdf;
    case 'png':
      return TablerIcons.file_type_png;
    case 'docx':
      return TablerIcons.file_type_docx;
    case 'doc':
      return TablerIcons.file_type_doc;
    default:
      return TablerIcons.file;
  }
}

void showSnackBar({required String message, bool success = true}) {
  Future.delayed(const Duration(milliseconds: 250), () {
    Get.snackbar(success ? 'Success' : 'Error', message,
        animationDuration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        backgroundColor: success ? ColorName.blue3 : ColorName.red3,
        colorText: Colors.white);
  });
}

String formatTime(String? dateString) {
  if (dateString == null) return '';
  try {
    final DateTime date = DateTime.parse(dateString);
    return DateFormat('h:mm a').format(date); // Formats to "06:10 PM"
  } catch (e) {
    return dateString; // Return original string if parsing fails
  }
}

Size textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    // textDirection: TextDirection.LTR,
  )..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

String formatDateTime(String? format, {bool date = true, bool time = false}) {
  if (format == null || format.isEmpty) {
    return '';
  }

  try {
    final dt = DateTime.parse(format);
    final d = date ? '${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}/${dt.year}' : '';
    final t = time ? '${(dt.hour % 12 == 0 ? 12 : dt.hour % 12).toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour < 12 ? 'AM' : 'PM'}' : '';
    return '$d${date && time ? ' ' : ''}$t'.trim();
  } catch (e) {
    return '';
  }
}

String formatDateAndTime(DateTime input){
  return DateFormat('MMM d').format(input);
}


Widget customLoadingIndicator({int children=8, EdgeInsets? padding, Widget? content}) {
  final decoration = BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white,
  );
  return Container(
    margin: padding,
    height: Get.height,
    child: Shimmer.fromColors(
        baseColor: ColorName.gray12,
        highlightColor: ColorName.gray11,
        child: content??ListView.builder(
          shrinkWrap: true,
            itemCount: children, // Adjust the count based on your needs
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  decoration: decoration,
                  height: 64,
                  width: 64,
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 4),
                  decoration: decoration,
                  height: 20,
                  width: 200,
                ),
                title: Container(
                  decoration: decoration,
                  height: 30,
                  width: 200,
                ),
              );
            })),
  );
}


Future<Position?> getCurrentCoordinates() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    final permission = await Permission.location.request();
    if(permission.isDenied){
      return null;

    }
  }
  // Check and request for permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get the current position
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
