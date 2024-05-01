import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_list.dart';
import '../repositories/home_repository.dart';

class GetProducts implements UseCase<ProductList, NoParams> {
  final HomeRepository homeRepository;

  GetProducts(this.homeRepository);

  @override
  Future<Either<Failure, ProductList>> call(NoParams params) {
    return homeRepository.getProductList();
  }
}
