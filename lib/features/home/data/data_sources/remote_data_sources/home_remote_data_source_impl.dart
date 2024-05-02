import '../../models/product_list_model.dart';
import 'home_remote_data_source.dart';
import 'retrofit/home_retrofit_client.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final HomeRetrofitClient _homeRetrofitClient;

  HomeRemoteDataSourceImpl({
    required HomeRetrofitClient homeRetrofitClient,
  }) : _homeRetrofitClient = homeRetrofitClient;

  @override
  Future<ProductListModel> getProductList() async {
    try {
      ProductListModel productList = await _homeRetrofitClient.getProductList();
      return productList;
    } catch (e) {
      rethrow;
    }
  }
}
