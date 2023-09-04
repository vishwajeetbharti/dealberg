class DealProducts {
  String? productName;
  String? price;
  String? description;
  String? image;
  String? id;
  int? quantity;

  DealProducts(
      {this.productName,
      this.price,
      this.description,
      this.id,
      this.quantity,
      this.image});
  factory DealProducts.fromJson(Map<String, dynamic> json) {
    return DealProducts(
      productName: json["productName"],
      price: json["price"],
      description: json["description"],
      id: json["id"],
      quantity: json["quantity"] ?? 0,
      image: json["image"] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "productName": productName,
      "price": price,
      "description": description,
      "id": id,
      "quantity": quantity,
    };
  }
}

//https://64f30ce8edfa0459f6c63c41.mockapi.io/products
