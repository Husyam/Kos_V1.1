// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:kos_mobile_v2_testing/presentation/orders/pdf/models/customer.dart';
import 'package:kos_mobile_v2_testing/presentation/orders/pdf/models/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;
  final String namaBank;
  final String statusPembayaran;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
    required this.namaBank,
    required this.statusPembayaran,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double pajak;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.pajak,
    required this.unitPrice,
  });
}
