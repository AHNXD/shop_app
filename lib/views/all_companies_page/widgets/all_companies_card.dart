import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controllers/companies_controller.dart';
import 'package:shop_app/models/company.dart';

import '../../../constans.dart';

class AllCompaniesCard extends StatelessWidget {
  AllCompaniesCard({
    super.key,
    required this.model,
  });
  final CompanyData model;
  final controller = Get.put(CompaniesController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 10 / 6,
          child: CachedNetworkImage(
            imageUrl: "${Constans.kImageBaseUrl}${model.image}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => Center(
              child: const CircularProgressIndicator(
                color: Constans.kMainColor,
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.wifi_tethering_error_rounded_sharp),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(model.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: Constans.kFontFamily))
      ],
    );
  }
}
