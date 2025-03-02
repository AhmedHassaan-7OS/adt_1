import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '/model/product_model.dart';
part 'fetch_product_event.dart';
part 'fetch_product_state.dart';

class FetchProductBloc extends Bloc<FetchProductEvent, FetchProductState> {
  FetchProductBloc() : super(FetchProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<FetchProductState> emit) async {
    if (state is FetchProductLoaded && (state as FetchProductLoaded).hasReachedMax) {
      return;
    }

    final currentState = state;
    List<Product> currentProducts = [];

    if (currentState is FetchProductLoaded) {
      currentProducts = currentState.products;
    }

    emit(currentProducts.isEmpty ? FetchProductLoading() : (currentState as FetchProductLoaded).copyWith(isLoadingMore: true));

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=${event.limit}&skip=${currentProducts.length}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newProducts = (data['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();

        final allProducts = [...currentProducts, ...newProducts];

        emit(FetchProductLoaded(
          products: allProducts,
          hasReachedMax: newProducts.length < event.limit,
        ));
      } else {
        emit(FetchProductError('Failed to load products'));
      }
    } catch (e) {
      emit(FetchProductError(e.toString()));
    }
  }
}