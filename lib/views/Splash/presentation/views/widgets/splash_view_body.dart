import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/main_page.dart';
import 'package:shop_app/utils/app_images.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';
import 'package:shop_app/views/on_boarding/on_boarding_page.dart';
import 'package:shop_app/views/salesman_app/trip_page/trips_page.dart';

import 'sliding_text.dart';

class SplashViewbody extends StatefulWidget {
  const SplashViewbody({super.key});

  @override
  State<SplashViewbody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewbody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(Assets.assetsImagesLogo),
        const SizedBox(
          height: 4,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 20), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        CacheHelper.getData(key: 'firstTime') ?? true
            ? Get.offAll(() => OnBoardingPage())
            : CacheHelper.getData(key: 'token') == null ||
                    (CacheHelper.getData(key: "longitude") == null &&
                        CacheHelper.getData(key: "latitude") == null)
                ? Get.offAll(() => LoginPage())
                : CacheHelper.getData(key: 'role') == 'customer'
                    ? Get.offAll(() => MainPage())
                    : Get.offAll(() => TripsPage());
      },
    );
  }
}
