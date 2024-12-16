// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/views/auth_pages/register_page/widgets/city_info_section.dart';
import 'package:shop_app/widgets/custom_pass_text_field.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

import '../../../../utils/avalible_time.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final controller = Get.put(AuthController());
  bool isLoading = false;
  late final TextEditingController fromTimeController;
  late final TextEditingController toTimeController;
  @override
  void initState() {
    fromTimeController = TextEditingController();
    toTimeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fromTimeController.dispose();
    toTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F4F6),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 40,
                  color: const Color(0xFF1C3132),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "انشاء حساب جديد",
                  style: TextStyle(
                      color: Color(0xFF1C3132),
                      fontSize: 26,
                      fontFamily: Constans.kFontFamily,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                onChanged: (val) {
                  controller.userName = val;
                },
                isUserName: true,
                textStyle: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                label: "الأسم",
                labelStyle: const TextStyle(
                    color: Colors.black,
                    // fontSize: 16,
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.normal),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 247, 244),
                focusedBorderColor: const Color(0xFF1C3132),
                enabledBorderColor: Colors.transparent,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color(0xFF1C3132),
                ),
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
                onChanged: (val) {
                  controller.phoneNumber = val;
                },
                isPhoneNumber: true,
                textStyle: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                label: "رقم الهاتف",
                labelStyle: const TextStyle(
                    color: Colors.black,
                    // fontSize: 16,
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.normal),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 247, 244),
                focusedBorderColor: const Color(0xFF1C3132),
                enabledBorderColor: Colors.transparent,
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Color(0xFF1C3132),
                ),
                keyboardType: TextInputType.phone),
            const SizedBox(
              height: 15,
            ),
            CustomPasswordTextField(
              onChanged: (val) {
                controller.password = val;
              },
              textStyle: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              label: "كلمة المرور",
              labelStyle: const TextStyle(
                  color: Colors.black,
                  // fontSize: 16,
                  fontFamily: Constans.kFontFamily,
                  fontWeight: FontWeight.normal),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              fillColor: const Color(0xFFF1F7F4),
              focusedBorderColor: const Color(0xFF1C3132),
              enabledBorderColor: Colors.transparent,
              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xFF1C3132),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CityInfoSection(),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                onChanged: (val) {
                  controller.locationDetails = val;
                },
                isLocation: true,
                textStyle: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                label: "الموقع بالتفصيل",
                labelStyle: const TextStyle(
                    color: Colors.black,
                    // fontSize: 16,
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.normal),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 247, 244),
                focusedBorderColor: const Color(0xFF1C3132),
                enabledBorderColor: Colors.transparent,
                prefixIcon: const Icon(
                  Icons.info,
                  color: Color(0xFF1C3132),
                ),
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              height: 65,
              onTap: isLoading
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        AvalibleTime.chooseAvailableTime(
                          context,
                          fromTimeController: fromTimeController,
                          toTimeController: toTimeController,
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "إلغاء",
                                style: TextStyle(
                                    color: Constans.kMainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (fromTimeController.text.isEmpty ||
                                    toTimeController.text.isEmpty) {
                                  showErrorSnackBar(
                                    "خطأ",
                                    "الرجاء تحديد التاريخ والوقت",
                                  );
                                } else {
                                  controller.startTime =
                                      fromTimeController.text;
                                  controller.endTime = toTimeController.text;
                                  Navigator.pop(context);
                                  try {
                                    isLoading = true;
                                    setState(() {});
                                    await handelRegisterStatus();
                                    // Get.to(RegisterPage());
                                    isLoading = false;
                                    setState(() {});
                                  } on Exception catch (e) {
                                    debugPrint('e: ${e}');
                                    isLoading = false;
                                    setState(() {});
                                  }
                                }
                              },
                              child: const Text(
                                "تأكيد",
                                style: TextStyle(
                                    color: Constans.kMainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      }
                    },
              title: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'انشاء حساب',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: Constans.kFontFamily,
                          fontSize: 24),
                    ),
              color: const Color(0xFF1C3132),
              padding: const EdgeInsets.symmetric(vertical: 12),
              titleStyle: const TextStyle(
                  fontFamily: Constans.kFontFamily,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              width: MediaQuery.sizeOf(context).width,
              // margin: EdgeInsets.symmetric(horizontal: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handelRegisterStatus() async {
    if (formKey.currentState!.validate()) {
      var locationStatus = await controller.locationService();
      if (locationStatus) {
        debugPrint('${controller.longitude} ${controller.latitude}');
        await controller.registerUser(context);
        setState(() {
          isLoading = false;
        });
      } else {
        showErrorSnackBar('لايمكن التسجيل بدون السماح بالوصول لصلاحيات الموقع',
                'الرجاء الدخول الى اعدادات التطبيق والسماح باذونات الوصول للموقع')
            .show(context);
      }
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
