import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension ListAsMenuItems<T> on List<T> {
  List<DropdownMenuItem<T>> asMenuItems() {
    return map((e) => DropdownMenuItem<T>(
          value: e,
          child: Text(e.toString(),  style: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray3),),
        )).toList();
  }
}

extension MapAsMenuItems<T> on Map<String, T> {
  List<DropdownMenuItem<T>> asMenuItems<K, V>() {
    return entries
        .map((entry) => DropdownMenuItem<T>(
              value: entry.value,
              child: Text(entry.key.toString(), style: Get.textTheme.titleMedium!.copyWith(color: ColorName.gray3),),
            ))
        .toList();
  }
}


extension FormatDate on String{
  String format(String format){
    final date = DateFormat(format).format(DateTime.parse(this));
    return date;
  }
}

extension FormatTime on String {

}
