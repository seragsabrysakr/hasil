class CartOrderModel {
  CartOrderModel({
    required this.key,
    required this.productId,
    required this.variationId,
    required this.variation,
    required this.quantity,
    required this.dataHash,
    required this.lineTaxData,
    required this.lineSubtotal,
    required this.lineSubtotalTax,
    required this.lineTotal,
    required this.lineTax,
    required this.data,
    required this.productName,
    required this.productTitle,
    required this.productPrice,
  });
  late final String key;
  late final int productId;
  late final int variationId;
  late final List<dynamic> variation;
  late final int quantity;
  late final String dataHash;
  late final LineTaxData lineTaxData;
  late final double lineSubtotal;
  late final double lineSubtotalTax;
  late final double lineTotal;
  late final double lineTax;
  late final Data data;
  late final String productName;
  late final String productTitle;
  late final String productPrice;

  CartOrderModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    variation = List.castFrom<dynamic, dynamic>(json['variation']);
    quantity = json['quantity'];
    dataHash = json['data_hash'];
    lineTaxData = LineTaxData.fromJson(json['line_tax_data']);
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'];
    lineTax = json['line_tax'];
    data = Data.fromJson(json['data']);
    productName = json['product_name'];
    productTitle = json['product_title'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['product_id'] = productId;
    _data['variation_id'] = variationId;
    _data['variation'] = variation;
    _data['quantity'] = quantity;
    _data['data_hash'] = dataHash;
    _data['line_tax_data'] = lineTaxData.toJson();
    _data['line_subtotal'] = lineSubtotal;
    _data['line_subtotal_tax'] = lineSubtotalTax;
    _data['line_total'] = lineTotal;
    _data['line_tax'] = lineTax;
    _data['data'] = data.toJson();
    _data['product_name'] = productName;
    _data['product_title'] = productTitle;
    _data['product_price'] = productPrice;
    return _data;
  }
}

class LineTaxData {
  LineTaxData({
    required this.subtotal,
    required this.total,
  });
  late final Subtotal subtotal;
  late final Total total;

  LineTaxData.fromJson(Map<String, dynamic> json) {
    subtotal = Subtotal.fromJson(json['subtotal']);
    total = Total.fromJson(json['total']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subtotal'] = subtotal.toJson();
    _data['total'] = total.toJson();
    return _data;
  }
}

class Subtotal {
  Subtotal({
    required this.first,
  });
  late final double first;

  Subtotal.fromJson(Map<String, dynamic> json) {
    first = json['1'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['1'] = first;
    return _data;
  }
}

class Total {
  Total({
    required this.first,
  });
  late final double first;

  Total.fromJson(Map<String, dynamic> json) {
    first = json['1'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['1'] = first;
    return _data;
  }
}

class Data {
  Data();

  Data.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
