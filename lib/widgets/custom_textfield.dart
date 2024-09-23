import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final Function(String val) onChanged;


  const CustomTextField({
    super.key,
    this.hintText,
    required this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Get.textTheme.bodyMedium!.copyWith(
          color: ColorName.gray6,
          fontWeight: FontWeight.normal,
        ),
        filled: true,
        fillColor: isEmpty ? ColorName.gray11 : ColorName.gray10, // Darker gray when not empty
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide:  BorderSide(color: isEmpty ? ColorName.gray11 : ColorName.gray10),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide:  BorderSide(color: isEmpty ? ColorName.gray11 : ColorName.gray10),
        ),
      ),
      onChanged: (value) {
        setState(() {
          isEmpty = value.isEmpty;
        });
        widget.onChanged(value);
      },
    );
  }
}