import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

abstract interface class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {}
