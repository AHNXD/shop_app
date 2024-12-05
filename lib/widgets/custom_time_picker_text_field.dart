import 'package:flutter/material.dart';

import '../constans.dart';

class CoustmTimePickerTextField extends StatelessWidget {
  const CoustmTimePickerTextField(
      {super.key, required this.labelText, required this.timeController});

  final String labelText;
  final TextEditingController timeController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: timeController,
      style: TextStyle(
          color: Colors.black, fontFamily: Constans.kFontFamily, fontSize: 13),
      readOnly: true,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Constans.kMainColor),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold)),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Constans.kMainColor,
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.white,
                  dialHandColor: Constans.kMainColor,
                  dialBackgroundColor: Colors.grey[200],
                  hourMinuteTextColor: Colors.black,
                  hourMinuteColor: Colors.grey[200],
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Constans.kMainColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedTime != null) {
          // ignore: use_build_context_synchronously
          timeController.text = pickedTime.format(context);
        }
      },
    );
  }
}
