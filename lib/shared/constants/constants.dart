import 'package:crew_app/models/user_model.dart';
import 'package:flutter/material.dart';

class Constants {
  static const baseUrl = 'https://server.movermate.com.au/api/v1';
  static String? authType;
  static String? token;
  static User? user;
  static String tabSelected = 'home';
}

Map<int, Color> color = {
  50: const Color.fromRGBO(255, 0, 0, .1),
  100: const Color.fromRGBO(255, 0, 0, .2),
  200: const Color.fromRGBO(255, 0, 0, .3),
  300: const Color.fromRGBO(255, 0, 0, .4),
  400: const Color.fromRGBO(255, 0, 0, .5),
  500: const Color.fromRGBO(255, 0, 0, .6),
  600: const Color.fromRGBO(255, 0, 0, .7),
  700: const Color.fromRGBO(255, 0, 0, .8),
  800: const Color.fromRGBO(255, 0, 0, .9),
  900: const Color.fromRGBO(255, 0, 0, 1),
};
