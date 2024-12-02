// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:flutter/material.dart";
import "package:kos_mobile_v2_testing/core/constants/variables.dart";
import "package:kos_mobile_v2_testing/data/models/responses/product_response_mode.dart";

import "../product_card.dart";

class CategoriesList extends StatelessWidget {
  final String title;
  final List<Product> items;
  const CategoriesList({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 18.0,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
              ), // Setengah dari 55.0 untuk mainAxisSpacing
              child: ProductCard(
                data: items[index],
                imageUrl: Variables.baseUrlImageProduct,
              ),
            );
          },
        ),
      ],
    );
  }
}
