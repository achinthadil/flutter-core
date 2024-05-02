import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/auth_model.dart';

part 'auth_retrofit_client.g.dart';

@RestApi()
abstract class AuthRetrofitClient {
  factory AuthRetrofitClient(Dio dio, {String baseUrl}) = _AuthRetrofitClient;

  @POST("/auth/login")
  Future<AuthModel> signInWithUserNameAndPassword(
    @Body() String data,
  );

  @GET("/auth/login")
  Future<AuthModel> getCurrentUser();
}
