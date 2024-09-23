import 'package:crew_app/widgets/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 170),
        child: Container(
          margin: const EdgeInsets.only(top: 56),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Message",
            style: Get.textTheme.titleLarge!.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
