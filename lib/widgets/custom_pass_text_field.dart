import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/helper/form_validators.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField(
      {super.key,
      required this.textStyle,
      required this.cursorColor,
      required this.label,
      required this.labelStyle,
      required this.filled,
      required this.fillColor,
      required this.focusedBorderColor,
      this.onChanged,
      required this.enabledBorderColor,
      this.suffixIconColor,
      this.prefixIcon,
      this.floatingLabelBehavior});
  final TextStyle textStyle;
  final Color cursorColor;
  final String label;
  final TextStyle labelStyle;
  final bool filled;
  final Color fillColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color? suffixIconColor;
  final Icon? prefixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final void Function(String)? onChanged;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obscureText = true;
  IconData suffixIcon = FontAwesomeIcons.eyeSlash;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: (value) {
        return FormValidators().weakPasswordValidator(value);
      },
      obscureText: obscureText,
      cursorColor: widget.cursorColor,
      style: widget.textStyle,
      decoration: InputDecoration(
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.fromLTRB(32, 16, 8, 16),
        label: Text(widget.label),
        labelStyle: widget.labelStyle,
        filled: widget.filled,
        fillColor: widget.fillColor,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.enabledBorderColor, width: 0.4),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.focusedBorderColor, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 8),
          child: widget.prefixIcon ?? Icon(Icons.lock),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                obscureText = (!obscureText);
                if (obscureText) {
                  suffixIcon = FontAwesomeIcons.eyeSlash;
                } else {
                  suffixIcon = FontAwesomeIcons.eye;
                }
              });
            },
            child: Icon(
              suffixIcon,
              size: 20,
              color:
                  widget.suffixIconColor ?? Color(0xFF1C3132).withOpacity(.7),
            ),
          ),
        ),
      ),
    );
  }
}
