import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is authenticated
    bool noUser = Constants.user == null;

    if (noUser) {
      // Redirect to login page if not authenticated
      return const RouteSettings(name: Routes.login);
    }

    // Allow access to the requested route if authenticated
    return null;
  }
}