import 'dart:convert';

class OrderRequestModel {
  final int? idPersonalData;
  final int? subTotal;
  final int? shippingCost;
  final int? totalCost;
  final String? paymentMethod;
  final String? paymentVaName;
  final List<Item>? items;

  OrderRequestModel({
    this.idPersonalData,
    this.subTotal,
    this.shippingCost,
    this.totalCost,
    this.paymentMethod,
    this.paymentVaName,
    this.items,
  });

  factory OrderRequestModel.fromJson(String str) =>
      OrderRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderRequestModel.fromMap(Map<String, dynamic> json) =>
      OrderRequestModel(
        idPersonalData: json["id_personal_data"],
        subTotal: json["sub_total"],
        shippingCost: json["shipping_cost"],
        totalCost: json["total_cost"],
        paymentMethod: json["payment_method"],
        paymentVaName: json["payment_va_name"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id_personal_data": idPersonalData,
        "sub_total": subTotal,
        "shipping_cost": shippingCost,
        "total_cost": totalCost,
        "payment_method": paymentMethod,
        "payment_va_name": paymentVaName,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  final int? idProduct;
  final int? quantity;

  Item({
    this.idProduct,
    this.quantity,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        idProduct: json["id_product"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "id_product": idProduct,
        "quantity": quantity,
      };
}
