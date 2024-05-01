part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final ProductList productList;

  HomeSuccess(this.productList);
}

final class HomeFailure extends HomeState {
  final String failure;

  HomeFailure(this.failure);
}
