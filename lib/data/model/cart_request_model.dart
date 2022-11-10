class CartRequestModel {
  int? userId;
  List<CartProducts>? products;

  CartRequestModel({this.userId, this.products});

  CartRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];

    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  String? productId;
  String? quantity;
  String? variationId = '0';
  String? customer_id;

  CartProducts({
    this.productId,
    this.quantity,
    this.variationId,
    this.customer_id,
  });

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    variationId = json['variation_id'];
    customer_id = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['variation_id'] = variationId;
    data['customer_id'] = customer_id;
    return data;
  }
}
