class ProductCart {
  dynamic id;
  dynamic title;
  dynamic content;
  dynamic image;
  dynamic thumbnail;
  dynamic userId;
  int quantity;

  ProductCart({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.userId,
    required this.quantity,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
    id: json["id"].toString(),
    title: json["title"].toString(),
    content: json["content"].toString(),
    image: json["image"],
    thumbnail: json["thumbnail"],
    userId: double.tryParse(json["userId"].toString()) ?? 0.0, // Convert userId to double or default to 0.0
    quantity: int.tryParse(json["quantity"].toString()) ?? 0, // Convert quantity to int or default to 0
  );
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
