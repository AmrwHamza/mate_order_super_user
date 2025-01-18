class GetAllProductsModul {
  List<Product>? products;
  String? message;

  GetAllProductsModul({this.products, this.message});

  GetAllProductsModul.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      products = <Product>[];
      json['data'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Product {
  int? id;
  int? storeId;
  String? name;
  int? amount;
  int? price;
  String? category;
  int? active;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.storeId,
      this.name,
      this.amount,
      this.price,
      this.category,
      this.active,
      this.imagePath,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    name = json['name'];
    amount = json['amount'];
    price = json['price'];
    category = json['category'];
    active = json['active'];
    imagePath = json['image_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['store_id'] = storeId;
    data['name'] = name;
    data['amount'] = amount;
    data['price'] = price;
    data['category'] = category;
    data['active'] = active;
    data['image_path'] = imagePath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
