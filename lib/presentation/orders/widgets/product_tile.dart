import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../data/models/responses/order_detail_response_model.dart';

class ProductTile extends StatelessWidget {
  final OrderItem data;
  const ProductTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //   child: Image.network(
          //     Variables.baseUrlImageProduct,
          //     width: 40.0,
          //     height: 40.0,
          //   ),
          // ),
          // const SpaceWidth(14.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.product!.name!,
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${data.product!.price?.currencyFormatRp} x ${data.quantity} = ${(data.product!.price! * data.quantity! + 8000).currencyFormatRp}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
