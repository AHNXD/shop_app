import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/company.dart';

import '../../constans.dart';
import '../../controllers/categories_compnies_controller.dart';
import 'widgets/categoirs_companies_grid_view.dart';

class CategoriesCompanies extends StatelessWidget {
  const CategoriesCompanies({super.key, required this.companyData});
  final CompanyData companyData;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xFFF3F4F6),
          title: Text(
            companyData.name!,
            style: TextStyle(
                fontFamily: Constans.kFontFamily, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<CategoriesCompniesController>(
            init: CategoriesCompniesController(),
            builder: (controller) {
              if (controller.categoryLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Constans.kMainColor,
                  ),
                );
              }
              return CategoirsCompaniesGridView(
                companyId: companyData.id,
              );
            }),
      ),
    );
  }
}
