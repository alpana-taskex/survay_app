import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

Widget getJobLoadingWidget({double height=200, int children = 3}){
  const color =  ColorName.gray6;
  return Column(
    children: List.generate(children, (i){
      return Container(
        height: height,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color
        ),
      );
    }),
  );
}