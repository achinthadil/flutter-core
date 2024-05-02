import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Auth>> signInWithUserNameAndPassword(
      {required String loginCredential});

  Future<Either<Failure, Auth>> currentUser();

  Future<Either<Failure, bool>> logout();
}
