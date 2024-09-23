import 'dart:io';
import 'package:crew_app/components/button_input.dart';
import 'package:crew_app/widgets/navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:crew_app/shared/constants/constants.dart';
import 'package:crew_app/shared/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crew_app/components/frequent_widgets.dart';
import 'package:crew_app/gen/assets.gen.dart';
import 'package:crew_app/gen/colors.gen.dart';
import 'package:crew_app/modules/account/account_controller.dart';
import 'package:crew_app/widgets/bottombar.dart';
import 'package:crew_app/widgets/dialog.dart';
import 'package:image_picker/image_picker.dart';

class Account extends GetView<AccountController> {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            vPad32,
            _buildAccountOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.profileHead.image().image,
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileText(),
          vPad18,
          _buildAvatarWithEditButton(),
          vPad18,
          _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildProfileText() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Text(
        'Profile',
        style: Get.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          color: ColorName.white,
        ),
      ),
    );
  }

  Widget _buildAvatarWithEditButton() {
    return Stack(
      children: [
        _buildAvatarImage(),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildAvatarImage() {
    return Obx(() {
      final avatarUrl = controller.user.value?.profileAvatarSrc;
      final isUpdating = controller.isAvatarUpdating.value;
      final localAvatarPath = controller.localAvatarPath.value;

      return SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(50), child: _buildImageContent(localAvatarPath, avatarUrl)),
            if (isUpdating) _buildLoadingOverlay(),
          ],
        ),
      );
    });
  }

  Widget _buildImageContent(String? localAvatarPath, String? avatarUrl) {
    if (localAvatarPath != null) {
      return Image.file(File(localAvatarPath), fit: BoxFit.cover);
    } else if (avatarUrl != null) {
      return CachedNetworkImage(
        imageUrl: avatarUrl,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            color: Colors.white,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
      );
    } else {
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: ColorName.blue12),
          child: const Icon(Icons.person, size: 50, color: ColorName.blue6));
    }
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: InkWell(
        onTap: () => Get.bottomSheet(_showCustomProfileSheet()),
        child: Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            color: ColorName.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            TablerIcons.camera,
            size: 16,
            color: ColorName.blue3,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          Constants.user?.name ?? 'Loading...',
          style: Get.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorName.white,
            height: 1.6,
          ),
        ),
        Text(
          Constants.user?.email ?? 'Loading...',
          style: Get.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.normal,
            color: ColorName.gray11,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildListTile(Assets.svgs.iconEditBlackBig.svg(), 'Edit Profile', controller.showProfile),
        _buildListTile(Assets.svgs.iconReset.svg(), 'Reset Password', controller.resetPassword),
        _buildListTile(Assets.svgs.iconFaqOutlineSvg.svg(), 'FAQs', controller.showFAQs),
        _buildListTile(Assets.svgs.iconHelpOutline.svg(), 'Help and Support', controller.showHelpAndSupport),
        _buildListTile(Assets.svgs.iconAboutOutline.svg(), 'About', controller.showAboutUs),
        _buildListTile(Assets.svgs.iconTCOutline.svg(), 'Term of Use', controller.showTermOfUse),
        _buildListTile(Assets.svgs.iconLanguageOutline.svg(), 'Language', controller.showLanguage),
        _buildListTile(Assets.svgs.iconPrivacyOutline.svg(), 'Privacy Policy', controller.showPrivacy),
        vPad20,
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildListTile(Widget asset, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      minVerticalPadding: 0,
      leading: asset,
      minLeadingWidth: 0,
      horizontalTitleGap: 12,
      minTileHeight: 46,
      title: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.normal,
          color: ColorName.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: _showCustomSignOutDialog,
      child: Container(
        margin: const EdgeInsets.fromLTRB(24, 4, 24, 4),
        alignment: Alignment.bottomLeft,
        child: Text(
          'Log Out',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.normal,
            color: ColorName.red1,
          ),
        ),
      ),
    );
  }

  Widget _showCustomProfileSheet() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 33),
      decoration: const BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonWidget.dividerWidget(width: 60, thickness: 5, color: ColorName.gray10.withOpacity(.2)),
          vPad12,
          InputButton(
            onPressed: () => controller.uploadAvatar(source: ImageSource.gallery),
            height: 44,
            backgroundColor: ColorName.blue12,
            elevation: 0,
            fontWeight: FontWeight.w400,
            labelColor: ColorName.blue3,
            label: 'Choose Photo',
            icon: Assets.svgs.iconGalleryOutline.svg(),
          ),
          vPad12,
          InputButton(
            onPressed: () => controller.uploadAvatar(source: ImageSource.camera),
            height: 44,
            backgroundColor: ColorName.blue12,
            elevation: 0,
            labelColor: ColorName.blue3,
            fontWeight: FontWeight.w400,
            label: 'Take a Photo',
            icon: Assets.svgs.iconCameraOutline.svg(),
          ),
          vPad32
        ],
      ),
    );
  }

  void _showCustomSignOutDialog() {
    CustomDialog(
      barrierDismissible: false,
      onSubmitted: () => Get.find<AccountController>().signOut(),
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
}

class WebViewExample extends StatelessWidget {
  final String url;
  final String title;

  const WebViewExample({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(
        Uri.parse(url),
      );
    return Scaffold(
      appBar: appBar(
        title: title,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
