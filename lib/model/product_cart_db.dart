class ProductCartDB {
  dynamic id;
  dynamic title;
  dynamic content;
  dynamic image;
  dynamic thumbnail;
  dynamic userId;
  int quantity;

  ProductCartDB({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.userId,
    required this.quantity,
  });

  factory ProductCartDB.fromJson(Map<String, dynamic> json) {
    return ProductCartDB(
      id: json["id"].toString(),
      title: json["title"].toString(),
      content: json["content"].toString(),
      image: json["image"],
      thumbnail: json["thumbnail"],
      userId: json["userId"].toString(),
      quantity: json["quantity"] is int ? json["quantity"] : int.tryParse(json["quantity"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image": image,
    "thumbnail": thumbnail,
    "userId": userId,
    "quantity": quantity,
  };
}

