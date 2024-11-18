import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/views/auth_pages/register_page/widgets/register_footer.dart';
import 'package:shop_app/views/auth_pages/register_page/widgets/register_form.dart';
import 'package:shop_app/views/auth_pages/register_page/widgets/register_logo_section.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (controller) {
              return controller.citiesLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.citiesError
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "حدث خطأ الرجاء التحقق من اتصال الانترنت واعادة المحاولة",
                              style:
                                  TextStyle(fontFamily: Constans.kFontFamily),
                            ),
                            CustomButton(
                              margin: EdgeInsets.all(16),
                              height: 50,
                              // titleStyle: TextStyle(),
                              color: Colors.green,
                              title: controller.citiesLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'اعد المحاولة',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: Constans.kFontFamily,
                                          fontWeight: FontWeight.bold),
                                    ),
                              onTap: controller.citiesLoading
                                  ? null
                                  : () {
                                      controller.getAllCities(context);
                                    },
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            const RegisterLogoSection(),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              margin: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height / 3 -
                                      20),
                              height:
                                  MediaQuery.sizeOf(context).height / 3 * 2 +
                                      20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 16),
                                color: const Color(0xFFF3F4F6),
                                height:
                                    MediaQuery.sizeOf(context).height / 3 * 2,
                                width: MediaQuery.sizeOf(context).width,
                                child: const SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      RegisterForm(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RegisterFooter()
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
            }),
      ),
    );
  }
}
