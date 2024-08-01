import 'dart:convert';

class OrderRequestModel {
  final int? personalDataId;
  final int? subTotal;
  final int? shippingCost;
  final String? paymentVaName;
  final int? totalCost;
  final String? paymentMethod;
  final List<Item>? items;

  OrderRequestModel({
    this.personalDataId,
    this.subTotal,
    this.shippingCost,
    this.paymentVaName,
    this.totalCost,
    this.paymentMethod,
    this.items,
  });

  factory OrderRequestModel.fromJson(String str) =>
      OrderRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderRequestModel.fromMap(Map<String, dynamic> json) =>
      OrderRequestModel(
        personalDataId: json["personal_data_id"],
        subTotal: json["sub_total"],
        shippingCost: json["shipping_cost"],
        paymentVaName: json["payment_va_name"],
        totalCost: json["total_cost"],
        paymentMethod: json["payment_method"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "personal_data_id": personalDataId,
        "sub_total": subTotal,
        "shipping_cost": shippingCost,
        "payment_va_name": paymentVaName,
        "total_cost": totalCost,
        "payment_method": paymentMethod,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  final int? productId;
  final int? quantity;

  Item({
    this.productId,
    this.quantity,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
