import '../../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> signInWithUserNameAndPassword({
    required String data,
  });

  Future<AuthModel?> getCurrentUserData();

  void logout();
}
