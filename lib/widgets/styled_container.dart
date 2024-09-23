import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class StyledContainer extends StatelessWidget {
  final Widget child;
  final double? height;

  const StyledContainer({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: ColorName.gray11.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
