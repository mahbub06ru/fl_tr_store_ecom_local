// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';

List<Product> productListFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productListToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  dynamic id;
  String? slug;
  String? url;
  dynamic title;
  dynamic content;
  dynamic image;
  dynamic thumbnail;
  String? status;
  String? category;
  String? publishedAt;
  String? updatedAt;
  dynamic userId;

  Product({
    this.id,
    this.slug,
    this.url,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.status,
    this.category,
    this.publishedAt,
    this.updatedAt,
    this.userId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"].toString(),
    slug: json["slug"],
    url: json["url"],
    title: json["title"].toString(),
    content: json["content"].toString(),
    image: json["image"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    category: json["category"],
    publishedAt: json["publishedAt"],
    updatedAt: json["updatedAt"],
    userId: json["userId"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "url": url,
    "title": title,
    "content": content,
    "image": image,
    "thumbnail": thumbnail,
    "status": status,
    "category": category,
    "publishedAt": publishedAt,
    "updatedAt": updatedAt,
    "userId": userId,
  };
}

class ProductDB {
  dynamic id;
  dynamic title;
  dynamic content;
  dynamic image;
  dynamic thumbnail;
  dynamic userId;

  ProductDB({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.userId,
  });

  factory ProductDB.fromJson(Map<String, dynamic> json) => ProductDB(
    id: json["id"].toString(),
    title: json["title"].toString(),
    content: json["content"].toString(),
    image: json["image"],
    thumbnail: json["thumbnail"],
    userId: json["userId"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image": image,
    "thumbnail": thumbnail,
    "userId": userId,
  };
}

