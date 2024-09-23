import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

AppBar appBar(
    {Widget? titleWidget, String? title, List<Widget>? actions, VoidCallback? onBack, bool showBackButton = true}) {
  return AppBar(
    toolbarHeight: 64,
    elevation: 1,
    shadowColor: ColorName.green12,
    surfaceTintColor: Colors.white,
    centerTitle: titleWidget == null ? true : false,
    scrolledUnderElevation: 0,
    automaticallyImplyLeading: showBackButton,
    backgroundColor: Colors.white,
    title: titleWidget ?? (title == null ? null : Text(title)),
    titleTextStyle: Get.textTheme.headlineSmall!.copyWith(color: ColorName.black, fontWeight: FontWeight.w500),
    leading: showBackButton
        ? IconButton(
            onPressed: onBack ?? () => Get.back(),
            icon: const Icon(TablerIcons.chevron_left),
          )
        : null,
    actions: actions,
  );
}
