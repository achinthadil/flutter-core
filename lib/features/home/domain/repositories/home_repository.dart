import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product_list.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, ProductList>> getProductList();
}
