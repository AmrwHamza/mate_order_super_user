import 'package:mate_order_super_user/Features/Home/data/models/get_all_products.dart';

class ArchiveModul {
  List<Product>? data;

  ArchiveModul({this.data});

  ArchiveModul.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


