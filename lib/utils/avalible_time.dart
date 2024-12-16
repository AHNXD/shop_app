import 'package:flutter/material.dart';

import '../constans.dart';
import '../widgets/custom_time_picker_text_field.dart';

class AvalibleTime {
  static chooseAvailableTime(BuildContext context,
      {required TextEditingController fromTimeController,
      required TextEditingController toTimeController,
      List<Widget>? actions}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold),
          title: const Text(
            "الأوقات المناسبة لاستلام طلباتك",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CoustmTimePickerTextField(
                labelText: "من الساعة",
                timeController: fromTimeController,
              ),
              SizedBox(height: 16),
              CoustmTimePickerTextField(
                labelText: "الى الساعة",
                timeController: toTimeController,
              ),
            ],
          ),
          actions: actions,
        );
      },
    );
  }
}
