import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/home_page_controller.dart';
import 'package:shop_app/controllers/shop_controller.dart';

class OffersPageView extends StatefulWidget {
  const OffersPageView({
    super.key,
    required this.dotPageController,
    required this.adsList,
  });
  final PageController dotPageController;
  final dynamic adsList;

  @override
  State<OffersPageView> createState() => _OffersPageViewState();
}

class _OffersPageViewState extends State<OffersPageView> {
  int currentIndex = 0;
  Timer? _timer;
  final ShopController controller = Get.put(ShopController());
  final homePageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    widget.dotPageController.addListener(_userScrollListener);
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.dotPageController.removeListener(_userScrollListener);
    super.dispose();
  }

//function to handle ads scroll
  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (widget.dotPageController.hasClients &&
          homePageController.adsList.isNotEmpty) {
        final nextPage = (currentIndex + 1) %
            (homePageController.adsList.isEmpty
                ? 0
                : homePageController.adsList.length);
        widget.dotPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _userScrollListener() {
    if (widget.dotPageController.page!.toInt() != currentIndex) {
      currentIndex = widget.dotPageController.page!.toInt();
      _startAutoSlide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController) {
      return Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: homePageController.errorLoading
              ? Center(
                  child: Text(
                    "حدث خطأ اثناء تحميل الاعلانات",
                    style: TextStyle(fontFamily: Constans.kFontFamily),
                  ),
                )
              : homePageController.adsList.isEmpty
                  ? Center(
                      child: Text(
                        "لايوجد اي اعلانات لعرضها",
                        style: TextStyle(fontFamily: Constans.kFontFamily),
                      ),
                    )
                  : PageView.builder(
                      controller: widget.dotPageController,
                      itemCount: homePageController.adsList.isEmpty
                          ? 0
                          : homePageController.adsList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "${Constans.kImageBaseUrl}${homePageController.adsList[index].image}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                  child: const CircularProgressIndicator(
                                color: Constans.kMainColor,
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        );
                      }));
    });
  }
}
