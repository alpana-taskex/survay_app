import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String label;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.value == widget.groupValue;

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? ColorName.blue3 : ColorName.gray5,
                width: 1.5,
              ),
              color: ColorName.white,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? ColorName.blue3 : ColorName.gray5,
                          width: 1.5,
                        ),
                        color:
                            isSelected ? ColorName.blue3 : Colors.transparent,
                      ),
                    ),
                  )
                : null,
          ),
          hPad6,
          Text(
            widget.label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorName.black,
                  fontWeight: FontWeight.normal,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
