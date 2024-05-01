import 'dart:convert';

import 'package:flutter_core_development/features/home/data/models/product_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_list.dart';

ProductList productListFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel extends ProductList {
  ProductListModel({
    List<ProductModel>? products,
    super.total,
    super.skip,
    super.limit,
  }) : super(
          products: products as List<Product>?,
        );

  ProductListModel copyWith({
    List<ProductModel>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      ProductListModel(
        products: products ?? this.products as List<ProductModel>?,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        products: json["products"] == null
            ? []
            : List<ProductModel>.from(json["products"]!
                .map((product) => ProductModel.fromJson(product))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from((products)!
                .map((product) => (product as ProductModel).toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
