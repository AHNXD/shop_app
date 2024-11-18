import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/views/auth_pages/register_page/register_page.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ليس لديك حساب ؟ ',
          style: TextStyle(
              fontFamily: Constans.kFontFamily,
              color: Colors.black.withOpacity(.6),
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => RegisterPage());
          },
          child: const Text(
            'انشاء حساب ',
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
