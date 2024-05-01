import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product_list.dart';
import '../../domain/usecases/get_products.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts _getProducts;

  HomeBloc({
    required GetProducts getProducts,
  })  : _getProducts = getProducts,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => ());
    on<LoadProducts>(_onLoadProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final res = await _getProducts(NoParams());

    res.fold((l) => emit(HomeFailure(l.message)), (r) => emit(HomeSuccess(r)));
  }
}
