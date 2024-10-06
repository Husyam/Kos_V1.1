import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/core/constants/variables.dart';
import 'package:kos_mobile_v2_testing/data/datasources/auth_local_datasource.dart';
import 'package:kos_mobile_v2_testing/data/models/responses/product_response_mode.dart';
import 'package:kos_mobile_v2_testing/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../core/core.dart';
import '../../../core/router/app_router.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  final String imageUrl;
  const ProductCard({
    super.key,
    required this.data,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          RouteConstants.productDetail,
          pathParameters: PathParameters().toMap(),
          extra: data,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.only(
          top: 10,
          right: 12,
          bottom: 10,
          left: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    data.image!.contains('http')
                        ? data.image!
                        : '${Variables.baseUrlImageProduct}${data.image}',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.categoryGender!, // Replace with the appropriate field if available
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 2),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/Lokasi_marker.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.address!, // Replace with the appropriate field if available
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    // '${data.price!.currencyFormatRp} / data.rentalType',
                    '${data.price!.currencyFormatRp} / ${data.rentalType}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Sisa ${data.stock} Kamar', // Replace with the appropriate field if available
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 75,
                  width: 4,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    // onPressed: () {
                    //   context
                    //       .read<CheckoutBloc>()
                    //       .add(CheckoutEvent.addItem(data));
                    // },
                    onPressed: () async {
                      final isAuth = await AuthLocalDatasource().isAuth();
                      if (!isAuth) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Silahkan login terlebih dahulu',
                        );
                        await Future.delayed(const Duration(
                            seconds:
                                3)); // Tambahkan delay untuk menampilkan pesan QuickAlert
                        context.goNamed(RouteConstants.login);
                      } else {
                        context
                            .read<CheckoutBloc>()
                            .add(CheckoutEvent.addItem(data));
                      }
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 10.0,
                            offset: const Offset(0, 2),
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Assets.icons.order.svg(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
