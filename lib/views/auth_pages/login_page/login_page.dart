import 'package:flutter/material.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/curvy_clip_section.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF3F4F6),
        // backgroundColor: Color(0xFF425C59),
        // backgroundColor: Color(0xffecc200),
        body: Column(
          children: [
            Expanded(flex: 2, child: CurvyClipSection()),
            Expanded(
              flex: 3,
              child: LoginPageBody(),
            ),
          ],
        ),
      ),
    );
  }
}
