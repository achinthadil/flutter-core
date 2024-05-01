import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> currentUser() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Auth>> signInWithEmailAndPassword(
      {required String loginCredential}) {
    return _getAuthResponse(
      () async => await authRemoteDataSource
          .signInWithEmailAndPassword(loginCredential),
    );
  }

  Future<Either<Failure, Auth>> _getAuthResponse(
      Future<Auth> Function() fn) async {
    try {
      final authResponse = await fn();
      return right(authResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(Failure('Invalid credentials'));
      } else {
        return left(Failure('Failed to sign in'));
      }
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
