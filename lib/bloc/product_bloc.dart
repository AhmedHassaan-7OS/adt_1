import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    if (state is ProductLoaded && (state as ProductLoaded).hasReachedMax) {
      return;
    }

    final currentState = state;
    List<Product> currentProducts = [];

    if (currentState is ProductLoaded) {
      currentProducts = currentState.products;
    }

    emit(currentProducts.isEmpty ? ProductLoading() : (currentState as ProductLoaded).copyWith(isLoadingMore: true));

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=${event.limit}&skip=${currentProducts.length}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newProducts = (data['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();

        final allProducts = [...currentProducts, ...newProducts];

        emit(ProductLoaded(
          products: allProducts,
          hasReachedMax: newProducts.length < event.limit,
        ));
      } else {
        emit(ProductError('Failed to load products'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/search?q=${event.query}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = (data['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();

        emit(ProductLoaded(
          products: products,
          hasReachedMax: true,
        ));
      } else {
        emit(ProductError('Failed to search products'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}