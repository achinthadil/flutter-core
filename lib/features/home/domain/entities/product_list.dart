import 'product.dart';

class ProductList {
  final List<Product>? products;
  final int? total;
  final int? skip;
  final int? limit;

  ProductList({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });
}
