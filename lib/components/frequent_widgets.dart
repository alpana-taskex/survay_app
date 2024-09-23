import 'package:crew_app/gen/colors.gen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

Widget dottedLine({double vPadding = 16, double hPadding = 0}) => Padding(
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      child: const DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 2.0,
        dashLength: 2.0,
        dashGapLength: 4.0,
        dashRadius: 5,
        dashGapRadius: 5,
        dashColor: ColorName.gray10,
      ),
    );

List<BoxShadow> get boxShadow => [
      const BoxShadow(
        color: ColorName.gray11,
        blurRadius: 8,
        offset: Offset(-1, -1), // Shadow position
      )
    ];

Widget get spacer => const Spacer();

Widget get vPad92 => const SizedBox(height: 92);
Widget get vPad80 => const SizedBox(height: 80);
Widget get vPad72 => const SizedBox(height: 72);
Widget get vPad64 => const SizedBox(height: 64);
Widget get vPad48 => const SizedBox(height: 48);
Widget get vPad44 => const SizedBox(height: 44);
Widget get vPad40 => const SizedBox(height: 40);
Widget get vPad36 => const SizedBox(height: 36);
Widget get vPad32 => const SizedBox(height: 32);

Widget get vPad28 => const SizedBox(height: 28);

Widget get vPad24 => const SizedBox(height: 24);

Widget get vPad22 => const SizedBox(height: 22);

Widget get vPad26 => const SizedBox(height: 26);

Widget get vPad20 => const SizedBox(height: 20);

Widget get vPad16 => const SizedBox(height: 16);

Widget get vPad18 => const SizedBox(height: 18);

Widget get vPad14 => const SizedBox(height: 14);
Widget get vPad9 => const SizedBox(height: 9);

Widget get vPad12 => const SizedBox(height: 12);

Widget get vPad8 => const SizedBox(height: 8);

Widget get vPad4 => const SizedBox(height: 4);

Widget get vPad6 => const SizedBox(height: 6);

Widget get vPad2 => const SizedBox(height: 2);

Widget get hPad32 => const SizedBox(width: 32);

Widget get hPad90 => const SizedBox(width: 90);

Widget get hPad28 => const SizedBox(width: 28);

Widget get hPad24 => const SizedBox(width: 24);

Widget get hPad20 => const SizedBox(width: 20);

Widget get hPad16 => const SizedBox(width: 16);

Widget get hPad11 => const SizedBox(width: 11);

Widget get hPad6 => const SizedBox(width: 6);

Widget get hPad14 => const SizedBox(width: 14);

Widget get hPad12 => const SizedBox(width: 12);

Widget get hPad8 => const SizedBox(width: 8);

Widget get hPad4 => const SizedBox(width: 4);

Widget get hPad2 => const SizedBox(width: 2);

