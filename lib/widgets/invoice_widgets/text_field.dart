import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatefulWidget {
  final String label;
  final String label1;
  final String hintText;
  final RxString controllerValue;
  final bool enabled;
  final IconData? icon;
  final int? maxLine;
  final EdgeInsets? padding;
  final TextInputType? textType;

  const MyTextField({
    super.key,
    required this.label,
    required this.label1,
    required this.hintText,
    required this.controllerValue,
    this.maxLine,
    this.padding,
    this.textType,
    this.icon,
    this.enabled = true,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.controllerValue.value);

    // Sync the controller with the RxString
    _controller.addListener(() {
      if (_controller.text != widget.controllerValue.value) {
        widget.controllerValue.value = _controller.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: Get.theme.textTheme.bodySmall,
            ),
            hPad4,
            Text(
              widget.label1,
              style: const TextStyle(color: ColorName.red3),
            ),
          ],
        ),
        vPad8,
        TextFormField(
          keyboardType: widget.textType,
          enabled: widget.enabled,
          controller: _controller,
          maxLines: widget.maxLine,
          decoration: InputDecoration(
            contentPadding: widget.padding,
            prefixIcon: Icon(
              widget.icon,
              color: ColorName.blue1,
              size: 20,
            ),
            hintText: widget.hintText,
            hintStyle: Get.theme.textTheme.bodyMedium!.copyWith(
              color: ColorName.gray8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: ColorName.gray11.withOpacity(0.5),
          ),
          onChanged: (value) {
            // No need to update the RxString here because the listener is handling it
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}