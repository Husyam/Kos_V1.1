import 'dart:convert';

class HistoryOrderResponseModel {
  final List<HistoryOrder>? orders;

  HistoryOrderResponseModel({
    this.orders,
  });

  factory HistoryOrderResponseModel.fromJson(String str) =>
      HistoryOrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      HistoryOrderResponseModel(
        orders: json["orders"] == null
            ? []
            : List<HistoryOrder>.from(
                json["orders"]!.map((x) => HistoryOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toMap())),
      };
}

class HistoryOrder {
  final int? id;
  final int? userId;
  final int? personalDataId;
  final int? subTotal;
  final int? shippingCost;
  final int? totalCost;
  final String? status;
  final String? paymentMethod;
  final String? paymentVaName;
  final String? paymentVaNumber;
  final dynamic paymentEwallet;
  final String? transactionNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HistoryOrder({
    this.id,
    this.userId,
    this.personalDataId,
    this.subTotal,
    this.shippingCost,
    this.totalCost,
    this.status,
    this.paymentMethod,
    this.paymentVaName,
    this.paymentVaNumber,
    this.paymentEwallet,
    this.transactionNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryOrder.fromJson(String str) =>
      HistoryOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryOrder.fromMap(Map<String, dynamic> json) => HistoryOrder(
        id: json["id"],
        userId: json["user_id"],
        personalDataId: json["personal_data_id"],
        subTotal: json["sub_total"],
        shippingCost: json["shipping_cost"],
        totalCost: json["total_cost"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        paymentVaName: json["payment_va_name"],
        paymentVaNumber: json["payment_va_number"],
        paymentEwallet: json["payment_ewallet"],
        transactionNumber: json["transaction_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "personal_data_id": personalDataId,
        "sub_total": subTotal,
        "shipping_cost": shippingCost,
        "total_cost": totalCost,
        "status": status,
        "payment_method": paymentMethod,
        "payment_va_name": paymentVaName,
        "payment_va_number": paymentVaNumber,
        "payment_ewallet": paymentEwallet,
        "transaction_number": transactionNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
