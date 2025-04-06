import 'package:flutter/material.dart';
import 'package:shop_app/constans.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {super.key,
      required this.label,
      required this.prefixIcon,
      required this.items,
      this.onChanged,
      this.initialValue});
  final List<dynamic> items;
  var selectedValue = '';
  List<dynamic> drop = [];
  final String label;
  final Icon prefixIcon;
  final String? initialValue;
  final void Function(Object?)? onChanged;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    //selectedValue = items[0].name;
    drop = items;
    return DropdownButtonFormField(
      padding: const EdgeInsets.all(0),
      dropdownColor: const Color(0xFFF1F7F4),
      style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          height: 1,
          color: Colors.black,
          fontFamily: Constans.kFontFamily),
      elevation: 0,
      value: initialValue ?? (items.isNotEmpty ? items.first.name : null),
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Color(0xFF1C3132),
      ),
      items: drop.map(
        (e) {
          return DropdownMenuItem(
            value: e.name,
            child: Text(
              overflow: TextOverflow.ellipsis,
              e.name,
              maxLines: 1, // Limit to one line
              style: TextStyle(
                fontSize: 12.sp, // Adjust font size as needed
                fontFamily: Constans.kFontFamily,
              ),
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          border: InputBorder.none,
          fillColor: const Color(0xFFF1F7F4),
          filled: true,
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: Constans.kFontFamily,
            ),
          )),
    );
  }
}
