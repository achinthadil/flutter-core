import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class UserSignIn implements UseCase<Auth, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, Auth>> call(UserSignInParams params) {
    return authRepository.signInWithUserNameAndPassword(
      loginCredential: params.loginCredential,
    );
  }
}

class UserSignInParams {
  final String loginCredential;

  UserSignInParams({
    required this.loginCredential,
  });
}
