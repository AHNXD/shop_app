
import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';

class TripOrdersTaps extends StatelessWidget {
  const TripOrdersTaps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TabBar(
          indicatorColor: Constans.kMainColor,
          dividerColor: Colors.transparent,
          padding: EdgeInsets.all(0),
          labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 8),
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          onTap: (value) {
            debugPrint(value.toString());
          },
          tabs: const [
            Text(
              "قيد المعالجة",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constans.kFontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Text(
              "الارشيف",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: Constans.kFontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ]),
    );
  }
}
