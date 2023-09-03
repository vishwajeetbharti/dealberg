class DealProducts {
  String? productName;
  String? price;
  String? description;
  String? id;
  int? quantity;

  DealProducts({
    this.productName,
    this.price,
    this.description,
    this.id,
    this.quantity,
  });
  factory DealProducts.fromJson(Map<String, dynamic> json) {
    return DealProducts(
        productName: json["productName"],
        price: json["price"],
        description: json["description"],
        id: json["id"],
        quantity: json["quantity"] ?? 0);
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

class Cart {
  Cart({required this.protectedQuantity, required this.protectedDetails});
  int? protectedQuantity;
  DealProducts? protectedDetails;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        protectedQuantity: json['protectedQuantity'],
        protectedDetails: DealProducts.fromJson(json['protectedDetails']));
  }
}

//https://64f30ce8edfa0459f6c63c41.mockapi.io/products
