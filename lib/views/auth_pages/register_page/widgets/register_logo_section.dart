import 'package:flutter/material.dart';

class RegisterLogoSection extends StatelessWidget {
  const RegisterLogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      width: double.infinity,
      color: const Color(0xFF1C3132),
      child: Center(
          child: Image.asset(
        width: 250,
        'assets/images/logo.png',
        fit: BoxFit.cover,
      )),
    );
  }
}
