
import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';

class InvoiceInfo extends StatelessWidget {
  const InvoiceInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          maxRadius: 14,
          child: Icon(
            color: Colors.white,
            icon,
            size: 18,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontFamily: Constans.kFontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontFamily: Constans.kFontFamily,
                  fontSize: 13,
                  color: Colors.black.withOpacity(.5)),
            ),
          ],
        ),
      ],
    );
  }
}
