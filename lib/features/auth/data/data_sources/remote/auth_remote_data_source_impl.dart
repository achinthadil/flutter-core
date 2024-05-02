import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/core_constants.dart';
import '../../models/auth_model.dart';
import 'auth_remote_data_source.dart';
import 'retrofit/auth_retrofit_client.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final AuthRetrofitClient _authRetrofitClient;
  final SharedPreferences _prefs;

  AuthRemoteDataSourceImpl({
    required AuthRetrofitClient authRetrofitClient,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _authRetrofitClient = authRetrofitClient;

  @override
  Future<AuthModel> signInWithUserNameAndPassword({
    required String data,
  }) async {
    try {
      AuthModel authResponseModel =
          await _authRetrofitClient.signInWithUserNameAndPassword(data);
      debugPrint('Mock user model received.');
      persistUser(authResponseModel);
      return authResponseModel;
    } catch (error) {
      debugPrint('Error : $error');
      rethrow;
    }
  }

  @override
  Future<AuthModel?> getCurrentUserData() async {
    if (_prefs.getString(CoreConstants.userEmail) == null) {
      debugPrint('❌ User Not Logged In}');
      return null;
    }
    AuthModel authModel = await _authRetrofitClient.getCurrentUser();
    debugPrint('✅ Current user received : ${authModel.username}');
    return authModel;
  }

  @override
  void logout() {
    removeUser();
  }

  void persistUser(AuthModel authModel) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (authModel.username != null && authModel.id != null) {
      preferences.setString(CoreConstants.userToken, authModel.token!);
      preferences.setInt(CoreConstants.userID, authModel.id!);
      preferences.setString(CoreConstants.userName, authModel.username!);
      preferences.setString(CoreConstants.userEmail, authModel.email!);
      debugPrint('✅ User Data Saved');
    }
  }

  void removeUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(CoreConstants.userToken);
    preferences.remove(CoreConstants.userID);
    preferences.remove(CoreConstants.userName);
    preferences.remove(CoreConstants.userEmail);
    debugPrint('❌️ User Data Removed');
  }
}
