import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class CurrentUser implements UseCase<Auth, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
