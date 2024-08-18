import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/history_order_response_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';
import '../models/transaction_model.dart';
import '../pages/order_detail_page.dart';
import 'row_text.dart';

class OrderCard extends StatelessWidget {
  final HistoryOrder data;
  const OrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.idOrder != null) {
          context.pushNamed(
            RouteConstants.trackingOrder,
            pathParameters: PathParameters().toMap(),
            extra: data.idOrder,
          );
        } else {
          // Tangani kasus id null jika diperlukan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order ID is null')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(color: AppColors.black),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: AppColors.stroke),
                    color: AppColors.primary,
                  ),
                  child: Text(
                    data.status ?? '-',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // RowText(label: 'Status', value: data.status ?? '-'),
            const SpaceHeight(12.0),
            RowText(
              label: 'Total Harga',
              value: data.totalCost?.currencyFormatRp ?? '-',
            ),
            const SpaceHeight(12.0),
            //date
            RowText(
              label: 'Tanggal Pesanan',
              value: data.createdAt?.toString() ?? '-',
            ),
            const SpaceHeight(12.0),
            //payment va name
            RowText(
              label: 'Nama VA',
              value: data.paymentVaName ?? '-',
            ),
            const SpaceHeight(12.0),
            //payment va number
            RowText(
              label: 'Nomor Virtual Account',
              value: data.paymentVaNumber ?? '-',
            ),
          ],
        ),
      ),
    );
  }
}
