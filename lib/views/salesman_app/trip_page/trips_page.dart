// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/controllers/location_controller.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/utils/app_images.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';
import 'package:shop_app/views/salesman_app/trip_page/widgets/filter_trips.dart';
import 'package:shop_app/views/salesman_app/trip_page/widgets/invoice_bottomsheet.dart';
import 'package:shop_app/views/salesman_app/trip_page/widgets/trip_card.dart';
import 'package:shop_app/views/shimmer/shimmer_container.dart';

class TripsPage extends StatelessWidget {
  TripsPage({super.key});
  final authController = Get.put(AuthController());
  final locationController =
      Get.put(LocationController()); // إضافة الكونترولر هنا

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startFloat,
                floatingActionButton: UserContactBottomSheet(),
                backgroundColor: const Color(0xFFF3F4F6),
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          String fcmToken =
                              userInfo.getString('fcm_token').toString();

                          bool status = await authController.logout(context);
                          if (status) {
                            userInfo.clear();
                            userInfo.setString('fcm_token', fcmToken);
                            Get.offAll(const LoginPage());
                          } else {
                            showErrorSnackBar('حدث خطأ', "اعد المحاولة لاحقا")
                                .show(context);
                          }
                        } on Exception catch (e) {
                          debugPrint('e: ${e}');
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
                  backgroundColor: const Color(0xFFF3F4F6),
                  title: Text(
                    'الرحلات',
                    style: TextStyle(
                        fontFamily: Constans.kFontFamily,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        controller.showFilter = !controller.showFilter;
                        controller.update();
                      },
                      icon: Icon(Icons.filter_list)),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    FilterTrips(),
                    Expanded(
                      child: controller.tripsLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Constans.kMainColor,
                            ))
                          : controller.allTrips.isEmpty &&
                                  !controller.tripsLoading &&
                                  !controller.tripsLoadingError
                              ? Center(
                                  child: Text(
                                    "لا يوجد لديك اي رحلات بتاريخ ${controller.tripDate}",
                                    style: TextStyle(
                                        fontFamily: Constans.kFontFamily),
                                  ),
                                )
                              : !controller.tripsLoading &&
                                      controller.tripsLoadingError
                                  ? Center(
                                      child: Text(
                                        "حدث خطأ اثناء تحميل الرحلات ",
                                        style: TextStyle(
                                            fontFamily: Constans.kFontFamily),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: controller.tripsLoading
                                          ? 4
                                          : controller.allTrips.length,
                                      itemBuilder: (context, index) {
                                        return controller.tripsLoading
                                            ? ShimmerContainer(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                height: 150,
                                                circularRadius: 16,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 20),
                                              )
                                            : TripsCard(
                                                model:
                                                    controller.allTrips[index],
                                              );
                                      }),
                    ),
                  ],
                )),
          );
        });
  }
}
