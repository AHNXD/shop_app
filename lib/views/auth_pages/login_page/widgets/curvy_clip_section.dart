import 'package:flutter/material.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/my_custom_clipper.dart';

class CurvyClipSection extends StatelessWidget {
  const CurvyClipSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        color: const Color(0xFF1C3132),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 260,
          ),
        ),
      ),
    );
  }
}
