class CartModel {
  int? id;
  String? name;
  double price;
  int qty;
  String? image;

  CartModel({
    this.id,
    this.name,
    required this.price,
    required this.qty,
    this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "qty": qty,
      };

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }
}
