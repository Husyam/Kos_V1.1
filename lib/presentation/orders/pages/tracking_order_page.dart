// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/order_detail/order_detail_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../home/models/product_model.dart';
import '../../home/models/store_model.dart';
import '../models/track_record_model.dart';
import '../widgets/product_tile.dart';

class TrackingOrderPage extends StatefulWidget {
  final int orderId;
  const TrackingOrderPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  @override
  void initState() {
    context
        .read<OrderDetailBloc>()
        .add(OrderDetailEvent.getOrderDetail(widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Orders'),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text('No Data'),
              );
            },
            loaded: (orderDetail) {
              if (orderDetail.orderItems != null &&
                  orderDetail.orderItems!.isNotEmpty) {
                return ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderDetail.orderItems!.length,
                      itemBuilder: (context, index) {
                        if (index < orderDetail.orderItems!.length) {
                          return ProductTile(
                            data: orderDetail.orderItems![index],
                          );
                        } else {
                          return const SizedBox
                              .shrink(); // atau tangani kasus error
                        }
                      },
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                    ),
                    const SpaceHeight(24.0),
                    const Text(
                      'Info Pemesan',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SpaceHeight(20.0),
                    Text(
                      'Nama: ${orderDetail.personalData?.name ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Jenis Kelamin: ${orderDetail.personalData?.gender ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    Text(
                      'No Kontak: ${orderDetail.personalData?.contact ?? '-'}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Order items are empty'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
