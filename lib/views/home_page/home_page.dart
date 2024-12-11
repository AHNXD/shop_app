// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/utils/app_images.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';
import 'package:shop_app/views/cart_page/cart_page.dart';
import 'package:shop_app/views/home_page/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.assetsImagesLogo,
              width: 120,
              fit: BoxFit.cover,
            ),
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            Get.to(CartPage());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Image.asset(
              Assets.assetsImagesCartIcon,
              width: 25,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              String fcmToken = CacheHelper.getData(key:'fcm_token').toString();
              bool firstUse = CacheHelper.getData(key: 'hasFCMToken') ?? true;
              bool status = await controller.logout(context);
              if (status) {
                CacheHelper.clearData();
                CacheHelper.setString(key: 'fcm_token', value: fcmToken);
                CacheHelper.setBool(key:'hasFCMToken',value: firstUse);

                Get.offAll(const LoginPage());
              } else {
                showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا")
                    .show(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                Assets.assetsImagesLogoutIcon,
                width: 32,
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF3F4F6),
      body: HomePageBody(),
    );
  }
}
