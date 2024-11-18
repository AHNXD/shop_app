import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constans.dart';
import 'package:shop_app/controllers/salesman/trip_controller.dart';
import 'package:shop_app/views/auth_pages/login_page/widgets/custom_button.dart';

class FilterTrips extends StatefulWidget {
  const FilterTrips({super.key});

  @override
  State<FilterTrips> createState() => _FilterTripsState();
}

class _FilterTripsState extends State<FilterTrips> {
  String? startDate;
  String shownStartDate = DateTime.now().toString().substring(0, 11);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripPageController>(
        init: TripPageController(),
        builder: (controller) {
          return controller.showFilter
              ? Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تاريخ البدء',
                              style: TextStyle(
                                  fontFamily: Constans.kFontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final now = DateTime.now();
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(now.year + 1));
                                if (date != null) {
                                  shownStartDate =
                                      '${date.year}-${date.month}-${date.day}';
                                  startDate = date.toString().substring(0, 11);
                                  setState(() {});
                                  controller.tripDate = startDate;
                                  debugPrint(
                                      'controller.tripDate: ${controller.tripDate}');
                                }
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      height: 55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Center(
                                        child: Text(
                                          shownStartDate.toString(),
                                          style: TextStyle(
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
                      CustomButton(
                        onTap: controller.tripsLoading
                            ? null
                            : () async {
                                debugPrint(controller.tripDate);
                                await controller.getAllTrips(context);
                              },
                        height: 55,
                        margin: EdgeInsets.all(0),
                        width: 200,
                        title: controller.tripsLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "ابحث",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: Constans.kFontFamily),
                              ),
                        color: Constans.kMainColor,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}
