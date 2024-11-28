import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/companies_controller.dart';
import '../../../controllers/categories_compnies_controller.dart';
import '../../categories_companies/categories_companies.dart';
import '../../shimmer/shimmer_container.dart';
import 'all_companies_card.dart';

class AllCompaniesGridView extends StatelessWidget {
  AllCompaniesGridView({
    super.key,
    required this.companyController,
  });
  final CompaniesController companyController;
  final companiesCategoirsGridView = Get.put(CategoriesCompniesController());
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 12, crossAxisSpacing: 12, crossAxisCount: 2),
      itemCount: companyController.companiesLoading
          ? 10
          : companyController.companiesList.length,
      itemBuilder: (context, index) {
        return companyController.companiesLoading
            ? const ShimmerContainer(
                width: 200, height: 200, circularRadius: 16)
            : GestureDetector(
                onTap: () {
                  companiesCategoirsGridView.categoryList.clear();
                  companiesCategoirsGridView.getAllCategories();
                  Get.to(() => CategoriesCompanies(
                      companyData: companyController.companiesList[index]));
                },
                child: Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: AllCompaniesCard(
                        model: companyController.companiesList[index]),
                  ),
                ),
              );
      },
    );
  }
}
