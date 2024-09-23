import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonWidget {
  static AppBar appBar(BuildContext context, String title, IconData? backIcon,
      {void Function()? callback}) {
    return AppBar(
      leading: backIcon == null
          ? null
          : IconButton(
              icon: Icon(backIcon, color: Colors.white),
              onPressed: () {
                if (callback != null) {
                  callback();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.deepPurple,
      elevation: 0.0,
    );
  }

  static SizedBox rowHeight({double height = 30}) {
    return SizedBox(height: height);
  }

  static SizedBox rowWidth({double width = 30}) {
    return SizedBox(width: width);
  }

  static SvgPicture svgWidget(String path) {
    return SvgPicture.asset(path);
  }

  static Widget dividerWidget(
      {double? thickness, required double width, Color? color, double? round}) {
    return Container(
      height: thickness,
      width: width,
      decoration: BoxDecoration(
        color: color ?? ColorName.gray4,
        borderRadius: BorderRadius.circular(round ?? 0)
      ),
    );
  }


}
