import 'package:dio/dio.dart';
import 'package:flutter_core_development/features/home/domain/entities/product_list.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/remote_data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  const HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, ProductList>> getProductList() async {
    try {
      final productResponse = await homeRemoteDataSource.getProductList();
      return right(productResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(Failure('Invalid credentials'));
      } else if (e.response?.statusCode == 500) {
        return left(Failure('Server Error'));
      } else {
        return left(Failure(
            'Failed to Load with error Code :: ${e.response?.statusCode}'));
      }
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
