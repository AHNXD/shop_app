import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';
// ignore: unused_import
import 'package:shop_app/views/auth_pages/login_page/widgets/my_custom_clipper.dart';
import 'package:shop_app/views/order_page/widgets/my_custom_clipper.dart';

class UpperClipper extends StatelessWidget {
  const UpperClipper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper2(),
      child: Container(
        height: MediaQuery.sizeOf(context).height / 3,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 177, 216, 177),
          Constans.kMainColor
        ])),
        child: Image.asset(
          'assets/images/card_background.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
