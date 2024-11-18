import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/login_page_footer.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/login_form.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                    "مرحباً",
                    style: TextStyle(
                        color: Color(0xFF1C3132),
                        fontSize: 32,
                        fontFamily: Constans.kFontFamily,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const LoginForm(),
              const SizedBox(
                height: 16,
              ),
              const LoginFooter()
            ],
          ),
        ),
      ),
    );
  }
}
