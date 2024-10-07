// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kos_mobile_v2_testing/core/components/buttons.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/bloc/order_detail/order_detail_bloc.dart';

import '../../../core/components/spaces.dart';

import '../pdf_api/model/customer.dart';
import '../pdf_api/model/invoice.dart';
import '../pdf_api/model/supplier.dart';
import '../pdf_api/pdf_api.dart';
import '../pdf_api/pdf_invoice_api.dart';
import '../widgets/button_widget.dart';
import '../widgets/product_tile.dart';

class TrackingOrderPage extends StatefulWidget {
  final int orderId;
  const TrackingOrderPage({
    super.key,
    required this.orderId,
  });

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
                    const SpaceHeight(16.0),
                    ButtonWidget(
                      text: 'Invoice PDF',
                      onClicked: () async {
                        final date = DateTime.now();
                        final dueDate = date.add(const Duration(days: 7));

                        // Buat supplier dari pemilik kos
                        final supplier = Supplier(
                          name: orderDetail
                                  .orderItems?.first.product?.nameOwner ??
                              'Pemilik Kos',
                          address:
                              orderDetail.orderItems?.first.product?.address ??
                                  'Alamat Kos',
                          paymentInfo: 'Informasi Pembayaran',
                        );

                        // Buat customer dari data pemesan
                        final customer = Customer(
                          name: orderDetail.personalData?.name ?? '-',
                          contact: orderDetail.personalData?.contact ?? '-',
                        );

                        // Buat invoice item dari data pemesanan
                        final items = orderDetail.orderItems!.map((item) {
                          return InvoiceItem(
                            description: item.product?.name ?? '-',
                            date: orderDetail.updatedAt ?? DateTime.now(),
                            quantity: item.quantity?.toInt() ?? 0,
                            unitPrice: orderDetail.subTotal!.toDouble(),
                            pajak:
                                8000, // Anda dapat mengganti ini dengan nilai pajak yang sebenarnya
                            //unitPrice + vat
                          );
                        }).toList();

                        // Buat invoice info
                        final invoiceInfo = InvoiceInfo(
                          description:
                              'Invoice ini dapat digunakan sebagai bukti pembayaran',
                          number: orderDetail.transactionNumber ?? 'INV-001',
                          date: date,
                          dueDate: dueDate,
                        );

                        // Buat invoice
                        final invoice = Invoice(
                          supplier: supplier,
                          customer: customer,
                          info: invoiceInfo,
                          items: items,
                        );

                        final pdfFile = await PdfInvoiceApi.generate(invoice);

                        PdfApi.openFile(pdfFile);
                      },
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
