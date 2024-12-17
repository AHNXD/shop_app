import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';
import 'package:shop_app/widgets/custom_pass_text_field.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final controller = Get.put(AuthController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextField(
            onChanged: (val) {
              controller.phoneNumber = val;
            },
            isPhoneNumber: true,
            textStyle: const TextStyle(color: Color(0xFF1C3132)),
            cursorColor: const Color(0xFF1C3132),
            label: "رقم الهاتف",
            labelStyle: const TextStyle(
                color: Colors.black, fontFamily: Constans.kFontFamily),
            filled: true,
            fillColor: const Color.fromARGB(255, 241, 247, 244),
            focusedBorderColor: const Color(0xFF1C3132),
            enabledBorderColor: Colors.black,
            prefixIcon: const Icon(Icons.phone),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordTextField(
            onChanged: (val) {
              controller.password = val;
            },
            textStyle: const TextStyle(color: Color(0xFF1C3132)),
            cursorColor: const Color(0xFF1C3132),
            label: "كلمة المرور",
            labelStyle: const TextStyle(
                color: Colors.black, fontFamily: Constans.kFontFamily),
            filled: true,
            fillColor: const Color.fromARGB(255, 241, 247, 244),
            focusedBorderColor: const Color(0xFF1C3132),
            enabledBorderColor: Colors.black,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            height: 60,
            onTap: isLoading ||
                    controller.isgetLocation ||
                    controller.isUpdateProfile
                ? null
                : () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      await controller.loginUser(context);
                      debugPrint("validate");
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                    isLoading = false;
                    setState(() {});
                    // List<CityModel> cities = await controller.getAllCities();
                  },
            title: isLoading ||
                    controller.isgetLocation ||
                    controller.isUpdateProfile
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'تسجيل الدخول',
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
    );
  }
}
