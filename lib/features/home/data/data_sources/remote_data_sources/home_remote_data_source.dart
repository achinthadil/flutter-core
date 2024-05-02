import '../../models/product_list_model.dart';

abstract class HomeRemoteDataSource {
  Future<ProductListModel> getProductList();
}
