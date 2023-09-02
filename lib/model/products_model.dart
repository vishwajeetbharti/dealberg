class DealProducts {
  String? productName;
  String? price;
  String? description;
  String? id;

  DealProducts({
    this.productName,
    this.price,
    this.description,
    this.id,
  });
  factory DealProducts.fromJson(Map<String, dynamic> json) {
    return DealProducts(
      productName: json["productName"],
      price: json["price"],
      description: json["description"],
      id: json["id"],
    );
  }
}

//https://64f30ce8edfa0459f6c63c41.mockapi.io/products
