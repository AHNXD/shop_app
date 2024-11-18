import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/invoices_controller.dart';
import 'package:shop_app/models/company_model.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';

class FilterInvoices extends StatefulWidget {
  const FilterInvoices({super.key});

  @override
  State<FilterInvoices> createState() => _FilterInvoicesState();
}

class _FilterInvoicesState extends State<FilterInvoices> {
  String? selectedValue = '';
  String? selectedid;
  List<CompanyModel> drop = [];
  String? startDate;
  String shownStartDate = 'تاريخ البدء';
  String? endDate;
  String shownEndDate = 'تاريخ الانتهاء';
  bool isLoading = false;
  final controller = Get.put(InvoicesController());
  @override
  void initState() {
    super.initState();
    selectedValue = controller.companies.isEmpty?'':controller.companies[0].name;
    drop = controller.companies;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الشركة',
                    style: TextStyle(
                        fontFamily: Constans.kFontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: DropdownButtonFormField(
                      padding: const EdgeInsets.all(0),
                      dropdownColor: const Color(0xFFF1F7F4),
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1,
                          color: Colors.black,
                          fontFamily: Constans.kFontFamily),
                      elevation: 0,
                      value: selectedValue.toString(),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle,
                        color: Constans.kMainColor,
                      ),
                      items: drop.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.name,
                            child: Text(e.name),
                          );
                        },
                      ).toList(),
                      onChanged: (p) {
                        for (var i = 0; i < controller.companies.length; i++) {
                          if (controller.companies[i].name == p) {
                            debugPrint(i.toString());
                            selectedid = controller.companies[i].id.toString();
                          }
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          FontAwesomeIcons.buildingColumns,
                          size: 16,
                          color: Constans.kMainColor,
                        ),
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
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        label: null,
                        // Text(
                        //   'الشركة',
                        //   style: const TextStyle(
                        //     color: Colors.black,
                        //     fontFamily: Constans.kFontFamily,
                        //   ),
                        // )),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'تاريخ البدء',
                      style: TextStyle(
                          fontFamily: Constans.kFontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());
                        if (date != null) {
                          shownStartDate =
                              '${date.year}-${date.month}-${date.day}';
                          startDate = date.toString().substring(0, 11);
                          setState(() {});
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  shownStartDate.toString(),
                                  style: const TextStyle(
                                      fontFamily: Constans.kFontFamily,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تاريخ الانتهاء',
                    style: TextStyle(
                        fontFamily: Constans.kFontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());
                      if (date != null) {
                        shownEndDate = '${date.year}-${date.month}-${date.day}';
                        endDate = date.toString().substring(0, 11);
                        debugPrint('${startDate!}  ${endDate!}');
                        setState(() {});
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Center(
                              child: Text(
                                shownEndDate.toString(),
                                style: const TextStyle(
                                    fontFamily: Constans.kFontFamily,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          onTap: isLoading
              ? null
              : () async {
                  setState(() {
                    isLoading = true;
                  });
                  await controller.getAllInvoices(
                      selectedid ?? '', startDate ?? '', endDate ?? '',context);
                  isLoading = false;
                  setState(() {});
                },
          width: 200,
          title: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  "ابحث",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constans.kFontFamily),
                ),
          color: Constans.kMainColor,
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
