// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductResponseModel {
  final String? status;
  final Data? data;

  ProductResponseModel({
    this.status,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
      };
}

class Data {
  final int? currentPage;
  final List<Product>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };

  where(Function(dynamic product) param0) {}
}

class Product {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? nameOwner;
  final String? categoryGender;
  final String? noKontak;
  final int? price;
  final String? description;
  final int? stock;
  final String? address;
  final String? longitude;
  final String? latitude;
  final String? image;
  final int? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.categoryId,
    this.name,
    this.nameOwner,
    this.categoryGender,
    this.noKontak,
    this.price,
    this.description,
    this.stock,
    this.address,
    this.longitude,
    this.latitude,
    this.image,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        nameOwner: json["name_owner"],
        categoryGender: json["category_gender"],
        noKontak: json["no_kontak"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        image: json["image"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "name_owner": nameOwner,
        "category_gender": categoryGender,
        "no_kontak": noKontak,
        "price": price,
        "description": description,
        "stock": stock,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "image": image,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryId == categoryId &&
        other.name == name &&
        other.nameOwner == nameOwner &&
        other.categoryGender == categoryGender &&
        other.noKontak == noKontak &&
        other.price == price &&
        other.description == description &&
        other.stock == stock &&
        other.address == address &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.image == image &&
        other.isAvailable == isAvailable &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryId.hashCode ^
        name.hashCode ^
        nameOwner.hashCode ^
        categoryGender.hashCode ^
        noKontak.hashCode ^
        price.hashCode ^
        description.hashCode ^
        stock.hashCode ^
        address.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        image.hashCode ^
        isAvailable.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(String str) => Link.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
