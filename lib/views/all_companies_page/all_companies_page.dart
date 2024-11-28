import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constans.dart';
import '../../controllers/companies_controller.dart';
import 'widgets/all_compaines_grid_view.dart';

class AllCompaniesPage extends StatelessWidget {
  const AllCompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFF3F4F6),
          title: const Text(
            "جميع الشركات",
            style: TextStyle(
                fontFamily: Constans.kFontFamily, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<CompaniesController>(
            init: CompaniesController(),
            builder: (companyController) {
              if (companyController.companiesError) {
                return Text('فشل في تحميل الشركات');
              }
              if (companyController.companiesList.isEmpty &&
                  !companyController.companiesLoading) {
                return Text('لا يوجد شركات لعرضها');
              }
              return AllCompaniesGridView(
                companyController: companyController,
              );
            }),
      ),
    );
  }
}
