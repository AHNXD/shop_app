import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/auth_pages/register_page/widgets/custom_dropdown_menu.dart';

class CityInfoSection extends StatefulWidget {
  const CityInfoSection({
    super.key,
  });
  @override
  State<CityInfoSection> createState() => _CityInfoSectionState();
}

class _CityInfoSectionState extends State<CityInfoSection> {
  final controller = Get.put(AuthController());
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 2.5,
          child: CustomDropDown(
            onChanged: (val) {
              for (var i = 0; i < controller.cities.length; i++) {
                if (controller.cities[i].name == val) {
                  selectedIndex = i;
                  controller.addressId = "";
                  debugPrint('selectedCity: ${val}');
                  setState(() {});
                }
              }
            },
            label: 'المحافظة',
            prefixIcon: const Icon(Icons.location_on),
            items: controller.cities,
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: CustomDropDown(
            onChanged: (val) {
              for (var i = 0;
                  i < controller.cities[selectedIndex].addresses.length;
                  i++) {
                if (controller.cities[selectedIndex].addresses[i].name == val) {
                  controller.addressId = controller
                      .cities[selectedIndex].addresses[i].id
                      .toString();
                }
              }
              debugPrint('selected address $val');
            },
            label: 'المنطقة',
            prefixIcon: const Icon(Icons.my_location_outlined),
            items: controller.cities[selectedIndex].addresses,
          ),
        ),
      ],
    );
  }
}
