import 'dart:io';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/routes/app_pages.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final activeColor = const ColorFilter.mode(ColorName.blue3, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: double.infinity,
        height: Platform.isIOS ? 90 : 70,
        padding: Platform.isIOS
            ? const EdgeInsets.only(left: 20, right: 20, bottom: 20)
            : const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
        decoration: const BoxDecoration(
          color: ColorName.white,
          boxShadow: [
            BoxShadow(
              color: ColorName.gray11,
              blurRadius: 8,
              offset: Offset(-2, 0), // changes position of shadow
            )
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () {
              if (Constants.tabSelected != 'home') {
                Constants.tabSelected = 'home';
                Get.offNamed(Routes.home);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Constants.tabSelected == 'home'
                    ? Assets.svgs.iconHome.svg(colorFilter: activeColor)
                    : Assets.svgs.iconHome.svg(),
                vPad8,
                Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constants.tabSelected == 'home' ? FontWeight.w600:FontWeight.w500,

                      color: Constants.tabSelected == 'home' ? ColorName.blue3 : ColorName.gray6),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (Constants.tabSelected != 'calendar') {
                Get.offNamed(Routes.calendar);
                Constants.tabSelected = 'calendar';
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Constants.tabSelected == 'calendar'
                    ? Assets.svgs.iconCalendar.svg(colorFilter: activeColor)
                    : Assets.svgs.iconCalendar.svg(),
                vPad8,
                Text(
                  'Calendar',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constants.tabSelected == 'calendar' ? FontWeight.w600:FontWeight.w500,

                      color: Constants.tabSelected == 'calendar' ? ColorName.blue3 : ColorName.gray6),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (Constants.tabSelected != 'wallet') {
                Get.offNamed(Routes.wallet);
                Constants.tabSelected = 'wallet';
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Constants.tabSelected == 'wallet'
                    ? Assets.svgs.iconWallet.svg(colorFilter: activeColor)
                    : Assets.svgs.iconWallet.svg(),
                vPad8,
                Text(
                  'Wallet',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constants.tabSelected == 'wallet' ? FontWeight.w600:FontWeight.w500,

                      color: Constants.tabSelected == 'wallet' ? ColorName.blue3 : ColorName.gray6),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (Constants.tabSelected != 'messages') {
                Get.offNamed(Routes.message);
                Constants.tabSelected = 'messages';
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Constants.tabSelected == 'messages'
                    ? Assets.svgs.iconMessage.svg(colorFilter: activeColor)
                    : Assets.svgs.iconMessage.svg(),
                vPad8,
                Text(
                  'Messages',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constants.tabSelected == 'messages' ? FontWeight.w600:FontWeight.w500,

                      color: Constants.tabSelected == 'messages' ? ColorName.blue3 : ColorName.gray6),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (Constants.tabSelected != 'account') {
                Get.offNamed(Routes.account);
                Constants.tabSelected = 'account';
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Constants.tabSelected == 'account'
                    ? Assets.svgs.iconPerson.svg(colorFilter: activeColor)
                    : Assets.svgs.iconPerson.svg(),
                vPad8,
                Text(
                  'Account',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constants.tabSelected == 'account' ? FontWeight.w600:FontWeight.w500,
                      color: Constants.tabSelected == 'account' ? ColorName.blue3 : ColorName.gray6),
                )
              ],
            ),
          ),
        ]));
  }
}
