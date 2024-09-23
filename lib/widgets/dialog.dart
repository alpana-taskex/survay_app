import 'dart:ui';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  final Widget content;
  final double? height;
  final bool isAutoValidate;
  final String actionText;
  final String cancelText;
  final bool barrierDismissible;
  final bool showActions;
  final Widget? clearWidget;
  final Function()? onCanceled;
  final Function() onSubmitted;
  final Color? actionColor;

  const CustomDialog({
    required this.content,
    this.isAutoValidate = false,
    this.actionText = 'Submit',
    this.height,
    this.cancelText = 'Cancel',
    this.showActions = true,
    this.clearWidget,
    this.onCanceled,
    required this.onSubmitted,
    this.barrierDismissible = true,
    this.actionColor,
  });

  void show() {
    showGeneralDialog(
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => CustomAlertDialog(
        content: content,
        onSubmitted: onSubmitted,
        isAutoValidate: isAutoValidate,
        height: height,
        showActions: showActions,
        clearWidget: clearWidget,
        onCanceled: onCanceled,
        actionText: actionText,
        actionColor: actionColor,
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
      context: Get.context!,
    );
  }
}

class CustomAlertDialog extends StatefulWidget {
  final Widget content;

  final double? height;
  final bool isAutoValidate;
  final String actionText;
  final String cancelText;
  final bool showActions;
  final Widget? clearWidget;
  final Function()? onCanceled;
  final Function() onSubmitted;
  final Color? actionColor;

  const CustomAlertDialog({
    super.key,
    required this.content,
    this.isAutoValidate = false,
    this.actionText = 'Submit',
    this.height,
    this.cancelText = 'Cancel',
    this.showActions = true,
    this.clearWidget,
    this.onCanceled,
    required this.onSubmitted,
    this.actionColor,
  });

  @override
  CustomAlertDialogState createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      content: Container(
        constraints: widget.height == null ? null : BoxConstraints(maxHeight: widget.height!),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Form(key: formKey, child: widget.content),
        )),
      ),
      actions: [
        if (widget.showActions) ...[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                if (widget.onCanceled != null) ...[
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Get.back();
                        widget.onCanceled?.call();
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorName.blue11.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorName.blue12, width: 1),
                        ),
                        child: Text(
                          widget.cancelText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorName.blue3,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                    ),
                  ),
                  hPad16,
                ],
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (widget.isAutoValidate) {
                        if (formKey.currentState?.validate() ?? false) {
                          widget.onSubmitted();
                        }
                      } else {
                        widget.onSubmitted();
                      }
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.actionColor ?? ColorName.blue3,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.actionText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
