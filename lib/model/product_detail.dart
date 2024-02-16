// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  int? id;
  String? slug;
  String? url;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  String? status;
  String? category;
  String? publishedAt;
  String? updatedAt;
  int? userId;

  ProductDetail({
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

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"],
    slug: json["slug"],
    url: json["url"],
    title: json["title"],
    content: json["content"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    category: json["category"],
    publishedAt: json["publishedAt"],
    updatedAt: json["updatedAt"],
    userId: json["userId"],
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
