import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth_model.dart';
import '../../models/user_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @POST("/auth/login")
  Future<AuthModel> signInWithEmailAndPassword(
    @Body() String data,
  );

  @GET("/auth/me")
  Future<UserModel> getCurrentUser();
}
