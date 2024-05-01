import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/auth/domain/entities/auth.dart';
import '../../../constants/core_constants.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final SharedPreferences _prefs;

  AppUserCubit({
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        super(AppUserInitial());

  Future<void> updateAuthResponse(Auth? authResponse) async {
    if (authResponse == null) {
      emit(AppUserInitial());
    } else {
      //! save token to local storage here
      await _prefs
          .setString(CoreConstants.userToken, authResponse.token!)
          .then((bool success) {
        if (success) {
          emit(AppUserLoggedIn(authResponse));
        } else {
          emit(
              AppUserInitial()); // Handle failure in saving the token appropriately
        }
      });
    }
  }

  Future<void> logout() async {
    await _prefs.remove(CoreConstants.userToken);
    emit(AppUserInitial());
  }
}
