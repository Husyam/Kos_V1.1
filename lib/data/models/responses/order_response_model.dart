// import 'dart:convert';

// class OrderResponseModel {
//   final String? status;
//   final Order? order;
//   final String? message;

//   OrderResponseModel({
//     this.status,
//     this.order,
//     this.message,
//   });

//   factory OrderResponseModel.fromJson(String str) =>
//       OrderResponseModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
//       OrderResponseModel(
//         status: json["status"],
//         order: json["order"] == null ? null : Order.fromMap(json["order"]),
//         message: json["message"],
//       );

//   Map<String, dynamic> toMap() => {
//         "status": status,
//         "order": order?.toMap(),
//         "message": message,
//       };
// }

// class Order {
//   final int? userId;
//   final int? personalDataId;
//   final int? shippingCost;
//   final int? subTotal;
//   final int? totalCost;
//   final String? status;
//   final String? paymentMethod;
//   final String? transactionNumber;
//   final DateTime? updatedAt;
//   final DateTime? createdAt;
//   final int? id;
//   final String? paymentVaName;
//   final String? paymentVaNumber;
//   final User? user;
//   final List<OrderItem>? orderItems;

//   Order({
//     this.userId,
//     this.personalDataId,
//     this.shippingCost,
//     this.subTotal,
//     this.totalCost,
//     this.status,
//     this.paymentMethod,
//     this.transactionNumber,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//     this.paymentVaName,
//     this.paymentVaNumber,
//     this.user,
//     this.orderItems,
//   });

//   factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Order.fromMap(Map<String, dynamic> json) => Order(
//         userId: json["user_id"],
//         personalDataId: json["personal_data_id"],
//         shippingCost: json["shipping_cost"],
//         subTotal: json["sub_total"],
//         totalCost: json["total_cost"],
//         status: json["status"],
//         paymentMethod: json["payment_method"],
//         transactionNumber: json["transaction_number"],
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         id: json["id"],
//         paymentVaName: json["payment_va_name"],
//         paymentVaNumber: json["payment_va_number"],
//         user: json["user"] == null ? null : User.fromMap(json["user"]),
//         orderItems: json["order_items"] == null
//             ? []
//             : List<OrderItem>.from(
//                 json["order_items"]!.map((x) => OrderItem.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "user_id": userId,
//         "personal_data_id": personalDataId,
//         "shipping_cost": shippingCost,
//         "sub_total": subTotal,
//         "total_cost": totalCost,
//         "status": status,
//         "payment_method": paymentMethod,
//         "transaction_number": transactionNumber,
//         "updated_at": updatedAt?.toIso8601String(),
//         "created_at": createdAt?.toIso8601String(),
//         "id": id,
//         "payment_va_name": paymentVaName,
//         "payment_va_number": paymentVaNumber,
//         "user": user?.toMap(),
//         "order_items": orderItems == null
//             ? []
//             : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
//       };
// }

// class OrderItem {
//   final int? id;
//   final int? orderId;
//   final int? productId;
//   final int? quantity;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final Product? product;

//   OrderItem({
//     this.id,
//     this.orderId,
//     this.productId,
//     this.quantity,
//     this.createdAt,
//     this.updatedAt,
//     this.product,
//   });

//   factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
//         id: json["id"],
//         orderId: json["order_id"],
//         productId: json["product_id"],
//         quantity: json["quantity"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         product:
//             json["product"] == null ? null : Product.fromMap(json["product"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "order_id": orderId,
//         "product_id": productId,
//         "quantity": quantity,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "product": product?.toMap(),
//       };
// }

// class Product {
//   final int? id;
//   final int? categoryId;
//   final String? name;
//   final String? nameOwner;
//   final String? categoryGender;
//   final String? noKontak;
//   final int? price;
//   final String? description;
//   final int? stock;
//   final String? address;
//   final String? longitude;
//   final String? latitude;
//   final String? image;
//   final int? isAvailable;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   Product({
//     this.id,
//     this.categoryId,
//     this.name,
//     this.nameOwner,
//     this.categoryGender,
//     this.noKontak,
//     this.price,
//     this.description,
//     this.stock,
//     this.address,
//     this.longitude,
//     this.latitude,
//     this.image,
//     this.isAvailable,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         categoryId: json["category_id"],
//         name: json["name"],
//         nameOwner: json["name_owner"],
//         categoryGender: json["category_gender"],
//         noKontak: json["no_kontak"],
//         price: json["price"],
//         description: json["description"],
//         stock: json["stock"],
//         address: json["address"],
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//         image: json["image"],
//         isAvailable: json["is_available"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "category_id": categoryId,
//         "name": name,
//         "name_owner": nameOwner,
//         "category_gender": categoryGender,
//         "no_kontak": noKontak,
//         "price": price,
//         "description": description,
//         "stock": stock,
//         "address": address,
//         "longitude": longitude,
//         "latitude": latitude,
//         "image": image,
//         "is_available": isAvailable,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

// class User {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? roles;
//   final dynamic emailVerifiedAt;
//   final dynamic twoFactorSecret;
//   final dynamic twoFactorRecoveryCodes;
//   final dynamic twoFactorConfirmedAt;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.roles,
//     this.emailVerifiedAt,
//     this.twoFactorSecret,
//     this.twoFactorRecoveryCodes,
//     this.twoFactorConfirmedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory User.fromJson(String str) => User.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory User.fromMap(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         roles: json["roles"],
//         emailVerifiedAt: json["email_verified_at"],
//         twoFactorSecret: json["two_factor_secret"],
//         twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
//         twoFactorConfirmedAt: json["two_factor_confirmed_at"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "roles": roles,
//         "email_verified_at": emailVerifiedAt,
//         "two_factor_secret": twoFactorSecret,
//         "two_factor_recovery_codes": twoFactorRecoveryCodes,
//         "two_factor_confirmed_at": twoFactorConfirmedAt,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
import 'dart:convert';

class OrderResponseModel {
  final String? status;
  final Order? order;
  final String? message;

  OrderResponseModel({
    this.status,
    this.order,
    this.message,
  });

  factory OrderResponseModel.fromJson(String str) =>
      OrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(
        status: json["status"],
        order: json["order"] == null ? null : Order.fromMap(json["order"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "order": order?.toMap(),
        "message": message,
      };
}

class Order {
  final int? idUser;
  final int? idPersonalData;
  final int? shippingCost;
  final int? subTotal;
  final int? totalCost;
  final String? status;
  final String? paymentMethod;
  final String? transactionNumber;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? idOrder;
  final String? paymentVaName;
  final String? paymentVaNumber;
  final User? user;
  final List<OrderItem>? orderItems;
  final PersonalData? personalData;

  Order({
    this.idUser,
    this.idPersonalData,
    this.shippingCost,
    this.subTotal,
    this.totalCost,
    this.status,
    this.paymentMethod,
    this.transactionNumber,
    this.updatedAt,
    this.createdAt,
    this.idOrder,
    this.paymentVaName,
    this.paymentVaNumber,
    this.user,
    this.orderItems,
    this.personalData,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        idUser: json["id_user"],
        idPersonalData: json["id_personal_data"],
        shippingCost: json["shipping_cost"],
        subTotal: json["sub_total"],
        totalCost: json["total_cost"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        transactionNumber: json["transaction_number"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idOrder: json["id_order"],
        paymentVaName: json["payment_va_name"],
        paymentVaNumber: json["payment_va_number"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromMap(x))),
        personalData: json["personal_data"] == null
            ? null
            : PersonalData.fromMap(json["personal_data"]),
      );

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "id_personal_data": idPersonalData,
        "shipping_cost": shippingCost,
        "sub_total": subTotal,
        "total_cost": totalCost,
        "status": status,
        "payment_method": paymentMethod,
        "transaction_number": transactionNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id_order": idOrder,
        "payment_va_name": paymentVaName,
        "payment_va_number": paymentVaNumber,
        "user": user?.toMap(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id_personal_data": idPersonalData,
        "name": name,
        "gender": gender,
        "profession": profession,
        "contact": contact,
        "id_user": idUser,
        "is_default": isDefault,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
