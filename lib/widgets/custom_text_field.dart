import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/helper/form_validators.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textStyle,
    required this.cursorColor,
    required this.label,
    required this.labelStyle,
    required this.filled,
    required this.fillColor,
    required this.focusedBorderColor,
    required this.enabledBorderColor,
    this.prefixIcon,
    this.isEmail,
    this.isUserName,
    this.isPrice,
    this.isExplaination,
    this.onChanged,
    required this.keyboardType,
    this.floatingLabelBehavior,
    this.suffixIcon,
    this.isPhoneNumber,
    this.isLocation,
    this.controller,
    this.isEnabel,
    this.onTap,
  });
  final TextStyle textStyle;
  final Color cursorColor;
  final String label;
  final TextStyle labelStyle;
  final bool filled;
  final Color fillColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isEmail;
  final bool? isPhoneNumber;
  final bool? isUserName;
  final bool? isLocation;
  final bool? isPrice;
  final bool? isExplaination;
  final TextInputType keyboardType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? isEnabel;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      enabled: isEnabel,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: (value) {
        if (isEmail ?? false) {
          return FormValidators().emailValidator(value);
        } else if (isUserName ?? false) {
          return FormValidators().userNameValidator(value);
        } else if (isPhoneNumber ?? false) {
          return FormValidators().phoneNumberValidator(value);
        } else if (isPrice ?? false) {
          return FormValidators().priceValidator(value);
        } else if (isExplaination ?? false) {
          return FormValidators().explainationValidator(value);
        } else if (isLocation ?? false) {
          return FormValidators().locationDetailsValidator(value);
        }
        return null;
      },
      cursorColor: cursorColor,
      style: textStyle,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontFamily: Constans.kFontFamily, fontSize: 10),
        contentPadding: const EdgeInsets.fromLTRB(32, 16, 8, 16),
        label: Text(label),
        labelStyle: labelStyle,
        filled: filled,
        fillColor: fillColor,
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 0.4),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0), child: prefixIcon),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: suffixIcon,
        ),
      ),
    );
  }
}
