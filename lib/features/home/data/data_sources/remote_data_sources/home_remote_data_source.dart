import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/product_list_model.dart';

part 'home_remote_data_source.g.dart';

@RestApi()
abstract class HomeRemoteDataSource {
  factory HomeRemoteDataSource(Dio dio, {String baseUrl}) =
      _HomeRemoteDataSource;

  @GET("/products")
  Future<ProductListModel> getProductList();
}
