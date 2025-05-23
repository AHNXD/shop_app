import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/on_boarding_controller.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/views/privac_policy_page.dart/privacy_policy.dart';

class OnBoardingFooter extends StatelessWidget {
  const OnBoardingFooter({
    super.key,
  });

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("موافقة على تتبع الموقع",
            style: TextStyle(
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold,
              color: Constans.kMainColor,
              fontSize: 15,
            )),
        content: Text(
            "يجب عليك السماح للتطبيق بتتبع موقعك في الخلفية لضمان أفضل تجربة ومتابعة أداء مندوبي المبيعات.",
            style: TextStyle(
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                onTap: () => Navigator.of(context).pop(),
                title: Text(
                  'رفض',
                  style: TextStyle(
                    fontFamily: Constans.kFontFamily,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                color: Constans.kMainColor,
              ),
              CustomButton(
                onTap: () {
                  CacheHelper.setBool(key: 'firstTime', value: false);
                  debugPrint('الموافقة على تتبع الموقع وتغيير قيمة firstTime');
                  Get.offAll(LoginPage());
                },
                title: Text(
                  'موافقة',
                  style: TextStyle(
                    fontFamily: Constans.kFontFamily,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                color: Constans.kMainColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
        init: OnBoardingController(),
        builder: (controller) {
          return Column(
            children: [
              CustomButton(
                onTap: () {
                  if (controller.isChecked) {
                    _showLocationPermissionDialog(context);
                  } else {
                    showInfoSnackBar('حدث خطأ',
                            "عذرا لايمكنك المتابعة بدون الموافقة على سياسة الخصوصية ")
                        .show(context);
                  }
                },
                height: 52,
                title: Text(
                  'متابعة',
                  style: TextStyle(
                    fontFamily: Constans.kFontFamily,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Constans.kMainColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                      activeColor: Constans.kMainColor,
                      side: BorderSide(width: .5),
                      value: controller.isChecked,
                      onChanged: (val) {
                        controller.isChecked = val!;
                        controller.update();
                      }),
                  Expanded(
                    child: Text.rich(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        text: 'أؤكد أنني قرأت وأوافق على ',
                        style: TextStyle(
                            fontFamily: Constans.kFontFamily, fontSize: 12
                            // fontWeight: FontWeight.bold,
                            ),
                        children: [
                          TextSpan(
                            text: 'سياسة الخصوصية',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: Constans.kFontFamily,
                              fontWeight: FontWeight.bold,
                              color: Constans.kMainColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(PrivacyPolicyPage());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
