import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  // final images = const [
  //   Assets.assetsImagesShop2,
  //   Assets.assetsImagesShop3,
  //   Assets.assetsImagesShop4,
  // ];
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // final categoryNames = const [
  //   "T-Shirt",
  //   "shorts",
  //   "Pants",
  //   "Jackets",
  //   "T-shirt",
  //   "Pants",
  // ];
  PageController pageController = PageController(initialPage: 0);
}
