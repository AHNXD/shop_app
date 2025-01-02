import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/helper/cache_helper.dart';
import 'package:shop_app/helper/custom_snack_bar.dart';
import 'package:shop_app/utils/avalible_time.dart';
import 'package:shop_app/widgets/custom_text_field.dart';

import '../../constans.dart';
import '../auth_pages/login_page/widgets/custom_button.dart';
import 'widgets/cities_info_profile_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  late TextEditingController nameController;
  late TextEditingController locationDetailsController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  @override
  void initState() {
    super.initState();
    // _authController.cities.isEmpty
    //     ? _authController.getAllCities(context)
    //     : null;
    nameController = TextEditingController(
      text: CacheHelper.getData(key: 'name') ?? '',
    );
    locationDetailsController = TextEditingController(
      text: CacheHelper.getData(key: 'location_details') ?? '',
    );
    startTimeController = TextEditingController(
      text: CacheHelper.getData(key: 'start_time') ?? '',
    );
    endTimeController = TextEditingController(
      text: CacheHelper.getData(key: 'end_time') ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    locationDetailsController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      if (startTimeController.text.isEmpty || endTimeController.text.isEmpty) {
        showErrorSnackBar(
          "خطأ",
          'يجب تحديد وقت البداية والنهاية لإستلام طلباتك.',
        );
        return;
      }
      var locationStatus = await _authController.locationService();
      if (locationStatus) {
        debugPrint('${_authController.longitude} ${_authController.latitude}');
        _authController.userName = nameController.text;
        _authController.startTime = startTimeController.text;
        _authController.endTime = endTimeController.text;
        _authController.locationDetails = locationDetailsController.text;
        log(_authController.userName);
        log(_authController.startTime);
        log(_authController.endTime);
        log(_authController.longitude);
        log(_authController.latitude);
        log(_authController.locationDetails);
        log(_authController.addressId);
        _authController.updateUserProfile(
          context: context,
        );
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          messageText: Text(
              style: TextStyle(color: Colors.white),
              'لايمكن حفظ التغيرات بدون الوصل الى الموقع الرجاء الدخول الى اعدادات التطبيق والسماح باذونات الوصول للموقع '),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  void _selectAvailableTime() {
    AvalibleTime.chooseAvailableTime(
      context,
      fromTimeController: startTimeController,
      toTimeController: endTimeController,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "تأكيد",
            style: TextStyle(
              color: Constans.kMainColor,
              fontFamily: Constans.kFontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(
            fontFamily: Constans.kFontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: nameController,
                  textStyle: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  isUserName: true,
                  label: "الاسم",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 241, 247, 244),
                  focusedBorderColor: const Color(0xFF1C3132),
                  enabledBorderColor: Colors.transparent,
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: Color(0xFF1C3132),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                const CitiesInfoProfileSection(),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: locationDetailsController,
                  isLocation: true,
                  textStyle: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  label: "الموقع بالتفصيل",
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: Constans.kFontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 241, 247, 244),
                  focusedBorderColor: const Color(0xFF1C3132),
                  enabledBorderColor: Colors.transparent,
                  prefixIcon: const Icon(
                    Icons.info,
                    color: Color(0xFF1C3132),
                  ),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _selectAvailableTime,
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 247, 244),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.date_range_outlined,
                          color: Color(0xFF1C3132),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "الأوقات المناسبة لاستلام الطلبات",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: Constans.kFontFamily,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return CustomButton(
                      height: 55,
                      onTap:
                          controller.isgetLocation || controller.isUpdateProfile
                              ? null
                              : _saveProfile,
                      title:
                          controller.isUpdateProfile || controller.isgetLocation
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'حفظ التغيرات',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Constans.kFontFamily,
                                    fontSize: 17,
                                  ),
                                ),
                      color: Constans.kMainColor,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      titleStyle: const TextStyle(
                        fontFamily: Constans.kFontFamily,
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
