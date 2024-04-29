import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Auth>> signInWithEmailAndPassword(
      {required String loginCredential});

  Future<Either<Failure, User>> currentUser();
}
