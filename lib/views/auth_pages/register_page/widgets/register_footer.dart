import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/views/auth_pages/login_page/login_page.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ' لديك حساب بالفعل ؟ ',
          style: TextStyle(
              fontFamily: Constans.kFontFamily,
              color: Colors.black.withOpacity(.6),
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const LoginPage());
          },
          child: const Text(
            "تسجيل الدخول",
            style: TextStyle(
                fontFamily: Constans.kFontFamily,
                color: Color(0xFF1C3132),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
