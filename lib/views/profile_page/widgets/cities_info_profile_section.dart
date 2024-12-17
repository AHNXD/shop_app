import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constans.dart';
import '../../../controllers/auth_controller.dart';
import '../../../helper/cache_helper.dart';
import '../../../models/city_model.dart';
import '../../auth_pages/register_page/widgets/custom_dropdown_menu.dart';

class CitiesInfoProfileSection extends StatefulWidget {
  const CitiesInfoProfileSection({super.key});

  @override
  State<CitiesInfoProfileSection> createState() =>
      _CitiesInfoProfileSectionState();
}

class _CitiesInfoProfileSectionState extends State<CitiesInfoProfileSection> {
  final controller = Get.put(AuthController());

  String? selectedCity;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    // Initialize with cached values or null

    selectedCity = CacheHelper.getData(key: 'city_name');
    selectedAddress = CacheHelper.getData(key: 'address_name');
    controller.addressId = CacheHelper.getData(key: 'address_id');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (controller.citiesError) {
          return SizedBox();
        } else if (controller.citiesLoading) {
          return Center(
            child: CircularProgressIndicator(color: Constans.kMainColor),
          );
        }

        // Find the index of the cached city to set its addresses
        int selectedCityIndex = controller.cities.indexWhere(
          (city) => city.name == selectedCity,
        );
        if (selectedCityIndex == -1) selectedCityIndex = 0; // Default index

        List<Address> addresses = controller.cities.isNotEmpty
            ? controller.cities[selectedCityIndex].addresses
            : [];

        return Column(
          children: [
            CustomDropDown(
              initialValue: selectedCity,
              label: 'المحافظة',
              prefixIcon: const Icon(Icons.location_on),
              items: controller.cities,
              onChanged: (val) {
                setState(() {
                  selectedCity = val as String?;
                  selectedCityIndex = controller.cities.indexWhere(
                    (city) => city.name == selectedCity,
                  );
                  // Reset address when city changes
                  selectedAddress = null;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomDropDown(
              initialValue: selectedAddress,
              label: 'المنطقة',
              prefixIcon: const Icon(Icons.my_location_outlined),
              items: addresses,
              onChanged: (val) {
                setState(() {
                  selectedAddress = val as String?;
                  controller.addressId = addresses
                      .firstWhere(
                        (address) => address.name == selectedAddress,
                      )
                      .id
                      .toString();
                });
              },
            ),
          ],
        );
      },
    );
  }
}
