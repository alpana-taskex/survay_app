
import 'package:crew_app/app_binding.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/models/user_model.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'shared/constants/constants.dart';

void main() async {
  await initialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)async{
        Logger().d(Get.currentRoute);
        if([Routes.wallet, Routes.home].contains(Get.currentRoute)){

          _showCustomSignOutDialog();
        }else{
        }
      },
      child: GetMaterialApp(
        title: 'Crew App',
        initialBinding: AppBinding(),
        // navigatorObservers: [GetObserver()],
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        getPages: AppPages.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2061F8),
            onPrimary: const Color(0xFF2061F8),
          ),
          splashFactory: NoSplash.splashFactory,
          buttonTheme: const ButtonThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent
          ),
          iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(splashFactory: NoSplash.splashFactory),
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          primaryColor: ColorName.blue3,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'Poppins', color: Colors.black87, fontSize: 18)
          ),
          fontFamily: 'Poppins',
          useMaterial3: true,
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            displayMedium: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            displaySmall: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            headlineMedium: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            headlineSmall: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.black38,
            ),
            titleLarge: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
            titleMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey[800],
            ),
            titleSmall: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
            bodyLarge: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
            bodySmall: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey[600],
            ),
            labelLarge: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            labelSmall: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> initialization() async{
  await GetStorage.init();
  final box = GetStorage();

  if(box.hasData('user')){
    Constants.user = User.fromJson(box.read('user'));
  }
  if(box.hasData('token')){
    Constants.token = box.read('token');
  }
}



  void _showCustomSignOutDialog() {
    CustomDialog(
      barrierDismissible: false,
      onSubmitted: () {},
      onCanceled: () {},
      actionText: 'Yes!',
      cancelText: 'Cancel',
      content: Column(
        children: [
          vPad22,
          Assets.svgs.iconLogout.svg(height: 64),
          vPad12,
          Text(
            'Logout Account',
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              height: 3.0,
            ),
          ),
          vPad2,
          Text(
            'Are you sure you want to logout? Once you logout you need to login again?',
            textAlign: TextAlign.center,
            style: Get.textTheme.titleSmall!.copyWith(
              color: ColorName.black,
              fontWeight: FontWeight.normal,
              height: 2.0,
            ),
          ),
          vPad8
        ],
      ),
    ).show();
  }

