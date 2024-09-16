import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/extensions/src/context.dart';
import 'package:todos_by_bloc/core/models/models.dart';
import 'package:todos_by_bloc/core/models/src/product/product_model.dart';
import 'package:todos_by_bloc/core/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  const ProductCard._({
    Key? key,
    this.product,
    this.isLoading = false,
  }) : super(key: key);

  final ProductModel? product;
  final bool isLoading;

  factory ProductCard({required ProductModel product}) => ProductCard._(product: product);

  factory ProductCard.loading() => ProductCard._(isLoading: true);

  static final _decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        offset: Offset(0, -1),
        spreadRadius: 2,
        blurRadius: 5,
      ),
    ],
  );

  static TextStyle _priceStyle = GoogleFonts.prompt(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return DecoratedBox(
        decoration: _decoration,
        child: Container(
          width: 160,
          height: 226,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerView.rect(width: double.infinity, height: 120),
              const Gap(8),
              ShimmerView.rect(width: 100, height: 10),
              const Gap(8),
              ShimmerView.rect(width: 150, height: 5),
              const Gap(4),
              ShimmerView.rect(width: 70, height: 5),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerView.rect(width: 60, height: 10),
                  ShimmerView.rect(width: 20, height: 10),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: _decoration,
      child: Container(
        width: 160,
        height: 249,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppCachedNetworkImage(
                imageUrl: product?.thumbnail,
              ),
            ),
            const Gap(8),
            Text(
              product?.title ?? "",
              style: GoogleFonts.prompt(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              product?.description ?? "",
              style: GoogleFonts.prompt(
                color: Colors.grey.shade400,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text.rich(
                    pricesParser(
                      price: product?.price ?? 0,
                      discountPercent: product?.discountPercentage ?? 0,
                    ),
                    style: _priceStyle.copyWith(
                      color: context.theme.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(2),
                SizedBox(
                  width: 38,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 14),
                      const Gap(3),
                      Text(
                        "${(product?.rating ?? 0).toStringAsFixed(1)}",
                        style: GoogleFonts.prompt(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextSpan pricesParser({required double price, required double discountPercent}) {
    if (discountPercent == 0) {
      return TextSpan(
        text: "$price",
        children: [
          TextSpan(
            text: " THB",
            style: _priceStyle.copyWith(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      );
    } else {
      double summaryPrice = (price * discountPercent) / 100;
      return TextSpan(
        text: "${(price - summaryPrice).toStringAsFixed(2)} ",
        children: [
          TextSpan(
            text: '$price',
            style: _priceStyle.copyWith(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey,
            ),
          ),
          TextSpan(
            text: ' THB',
            style: _priceStyle.copyWith(
              color: Colors.grey,
              fontSize: 12,
            ),
          )
        ],
        style: _priceStyle.copyWith(color: Colors.red),
      );
    }
  }
}
