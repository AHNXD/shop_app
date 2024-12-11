import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/constans.dart';

class OnBoardingInfo extends StatelessWidget {
  const OnBoardingInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/on_boarding.json'),
        const SizedBox(
          height: 40,
        ),
        const Text.rich(
          TextSpan(
            text: 'اهلا بك في ',
            style: TextStyle(
                fontFamily: Constans.kFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 22),
            children: <TextSpan>[
              TextSpan(
                text: 'بروكر',
                style: TextStyle(
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.bold,
                    color: Constans.kMainColor,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          " اكتشف أحدث المنتجات بأسعار تنافسية وتسوق بسهولة من بين مجموعة واسعة من المنتجات التي تناسب احتياجاتك ثم احصل على مشترياتك بسرعة مع خدمات التوصيل الآمنة إلى المكان الذي تريد.",
          style: TextStyle(
            fontFamily: Constans.kFontFamily,
            height: 1.5,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
