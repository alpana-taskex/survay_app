import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddSurveyScreen extends StatelessWidget {
  const AddSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom decoration for text fields
    final InputDecoration customDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorName.blue1,
              image: DecorationImage(
                image: AssetImage(Assets.images.bg.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Survey',
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Name',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: customDecoration.copyWith(
                hintText: 'Jenny Wilson',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Email Address',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: customDecoration.copyWith(
                hintText: 'Enter Email Address',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Phone Number',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: customDecoration.copyWith(
                hintText: '+61 Enter Phone Number',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
