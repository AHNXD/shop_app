import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constans.dart';
import '../../../models/product_model.dart';

class ProductDeltailsImage extends StatelessWidget {
  const ProductDeltailsImage({
    super.key,
    required this.pageController,
    required this.product,
  });

  final PageController pageController;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: product.images?.length ?? 2,
            itemBuilder: (context, index) {
              //return Image.asset("assets/images/logo.png");
              return CachedNetworkImage(
                imageUrl: "${Constans.kImageBaseUrl}${product.images![index]}",
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                  color: Constans.kMainColor,
                )),
                errorWidget: (context, url, error) => const Icon(
                  Icons.wifi_tethering_error_rounded_sharp,
                  size: 45,
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: product.images?.length ?? 1,
                effect: CustomizableEffect(
                  dotDecoration: DotDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    width: 8,
                    height: 8,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  activeDotDecoration: DotDecoration(
                    color: Constans.kMainColor,
                    width: 10,
                    height: 10,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
