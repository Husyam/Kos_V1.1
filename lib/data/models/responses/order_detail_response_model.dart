import 'dart:convert';

class OrderDetailResponseModel {
  final OrderDetail? order;

  OrderDetailResponseModel({
    this.order,
  });

  factory OrderDetailResponseModel.fromJson(String str) =>
      OrderDetailResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetailResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderDetailResponseModel(
        order:
            json["order"] == null ? null : OrderDetail.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "order": order?.toMap(),
      };
}

class OrderDetail {
  final int? idOrder;
  final int? idUser;
  final int? idPersonalData;
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
  final List<OrderItem>? orderItems;
  final User? user;
  final PersonalData? personalData;

  OrderDetail({
    this.idOrder,
    this.idUser,
    this.idPersonalData,
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
    this.orderItems,
    this.user,
    this.personalData,
  });

  factory OrderDetail.fromJson(String str) =>
      OrderDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromMap(Map<String, dynamic> json) => OrderDetail(
        idOrder: json["id_order"],
        idUser: json["id_user"],
        idPersonalData: json["id_personal_data"],
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
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromMap(x))),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        personalData: json["personal_data"] == null
            ? null
            : PersonalData.fromMap(json["personal_data"]),
      );

  Map<String, dynamic> toMap() => {
        "id_order": idOrder,
        "id_user": idUser,
        "id_personal_data": idPersonalData,
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
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
        "user": user?.toMap(),
        "personal_data": personalData?.toMap(),
      };
}

class OrderItem {
  final int? idOrderItem;
  final int? idOrder;
  final int? idProduct;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  OrderItem({
    this.idOrderItem,
    this.idOrder,
    this.idProduct,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        idOrderItem: json["id_order_item"],
        idOrder: json["id_order"],
        idProduct: json["id_product"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id_order_item": idOrderItem,
        "id_order": idOrder,
        "id_product": idProduct,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toMap(),
      };
}

class Product {
  final int? idProduct;
  final int? idCategory;
  final int? idUser;
  final String? name;
  final String? nameOwner;
  final String? categoryGender;
  final String? noKontak;
  final int? price;
  final String? description;
  final int? stock;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? image;
  final String? multiImage;
  final int? isAvailable;
  final String? fasilitas;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.idProduct,
    this.idCategory,
    this.idUser,
    this.name,
    this.nameOwner,
    this.categoryGender,
    this.noKontak,
    this.price,
    this.description,
    this.stock,
    this.address,
    this.latitude,
    this.longitude,
    this.image,
    this.multiImage,
    this.isAvailable,
    this.fasilitas,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        idProduct: json["id_product"],
        idCategory: json["id_category"],
        idUser: json["id_user"],
        name: json["name"],
        nameOwner: json["name_owner"],
        categoryGender: json["category_gender"],
        noKontak: json["no_kontak"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        multiImage: json["multi_image"],
        isAvailable: json["is_available"],
        fasilitas: json["fasilitas"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id_product": idProduct,
        "id_category": idCategory,
        "id_user": idUser,
        "name": name,
        "name_owner": nameOwner,
        "category_gender": categoryGender,
        "no_kontak": noKontak,
        "price": price,
        "description": description,
        "stock": stock,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "multi_image": multiImage,
        "is_available": isAvailable,
        "fasilitas": fasilitas,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PersonalData {
  final int? idPersonalData;
  final String? name;
  final String? gender;
  final String? profession;
  final String? contact;
  final int? idUser;
  final int? isDefault;
  final dynamic createdAt;
  final dynamic updatedAt;

  PersonalData({
    this.idPersonalData,
    this.name,
    this.gender,
    this.profession,
    this.contact,
    this.idUser,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory PersonalData.fromJson(String str) =>
      PersonalData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalData.fromMap(Map<String, dynamic> json) => PersonalData(
        idPersonalData: json["id_personal_data"],
        name: json["name"],
        gender: json["gender"],
        profession: json["profession"],
        contact: json["contact"],
        idUser: json["id_user"],
        isDefault: json["is_default"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id_personal_data": idPersonalData,
        "name": name,
        "gender": gender,
        "profession": profession,
        "contact": contact,
        "id_user": idUser,
        "is_default": isDefault,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class User {
  final int? idUser;
  final String? name;
  final String? email;
  final String? fcmId;
  final String? phone;
  final String? roles;
  final dynamic emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.idUser,
    this.name,
    this.email,
    this.fcmId,
    this.phone,
    this.roles,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        name: json["name"],
        email: json["email"],
        fcmId: json["fcm_id"],
        phone: json["phone"],
        roles: json["roles"],
        emailVerifiedAt: json["email_verified_at"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmedAt: json["two_factor_confirmed_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "fcm_id": fcmId,
        "phone": phone,
        "roles": roles,
        "email_verified_at": emailVerifiedAt,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
