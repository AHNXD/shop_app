import 'package:flutter/material.dart';
import 'package:shop_app/views/on_boarding/widgets/on_boarding_footer.dart';
import 'package:shop_app/views/on_boarding/widgets/on_boarding_info.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OnBoardingInfo(),
              OnBoardingFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
