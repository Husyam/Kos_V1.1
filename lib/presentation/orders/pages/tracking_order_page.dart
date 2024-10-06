// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    // ButtonWidget(
                    //   text: 'Invoice PDF',
                    //   onClicked: () async {
                    //     final date = DateTime.now();
                    //     final dueDate = date.add(Duration(days: 7));

                    //     // Buat supplier dari pemilik kos
                    //     final supplier = Supplier(
                    //       name:
                    //           'Pemilik Kos', // Anda dapat mengganti ini dengan nama pemilik kos yang sebenarnya
                    //       address:
                    //           'Alamat Kos', // Anda dapat mengganti ini dengan alamat kos yang sebenarnya
                    //       paymentInfo:
                    //           'Informasi Pembayaran', // Anda dapat mengganti ini dengan informasi pembayaran yang sebenarnya
                    //     );

                    //     // Buat customer dari data pemesan
                    //     final customer = Customer(
                    //       name: orderDetail.personalData?.name ?? '-',
                    //       address:
                    //           'Alamat Pemesanan', // Anda dapat mengganti ini dengan alamat pemesan yang sebenarnya
                    //     );

                    //     // Buat invoice item dari data pemesanan
                    //     final items = orderDetail.orderItems!.map((item) {
                    //       return InvoiceItem(
                    //         description: item.product?.name ?? '-',
                    //         date: DateTime.now(),
                    //         quantity: item.quantity?.toInt() ?? 0,
                    //         vat:
                    //             0.0, // Anda dapat mengganti ini dengan nilai pajak yang sebenarnya
                    //         unitPrice: item.product?.price?.toDouble() ??
                    //             0.0, // Anda dapat mengganti ini dengan harga satuan yang sebenarnya
                    //       );
                    //     }).toList();

                    //     // Buat invoice info
                    //     final invoiceInfo = InvoiceInfo(
                    //       description:
                    //           'My description...', // Anda dapat mengganti ini dengan deskripsi yang sebenarnya
                    //       number: '${DateTime.now().year}-9999',
                    //       date: date,
                    //       dueDate: dueDate,
                    //     );

                    //     // Buat invoice
                    //     final invoice = Invoice(
                    //       supplier: supplier,
                    //       customer: customer,
                    //       info: invoiceInfo,
                    //       items: items,
                    //     );

                    //     final pdfFile = await PdfInvoiceApi.generate(invoice);

                    //     PdfApi.openFile(pdfFile);
                    //   },
                    // ),
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
