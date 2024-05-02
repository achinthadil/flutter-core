import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/product_list_model.dart';

part 'home_retrofit_client.g.dart';

@RestApi()
abstract class HomeRetrofitClient {
  factory HomeRetrofitClient(Dio dio, {String baseUrl}) = _HomeRetrofitClient;

  @GET("/products")
  Future<ProductListModel> getProductList();
}
