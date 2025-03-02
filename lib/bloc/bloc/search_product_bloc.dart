import 'dart:convert';
import 'package:adt_1/model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  SearchProductBloc() : super(SearchProductInitial()) {
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onSearchProducts(SearchProducts event, Emitter<SearchProductState> emit) async {
    emit(SearchProductLoading());

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/search?q=${event.query}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = (data['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();

        emit(SearchProductLoaded(
          products: products,
          hasReachedMax: true,
        ));
      } else {
        emit(SearchProductError('Failed to search products'));
      }
    } catch (e) {
      emit(SearchProductError(e.toString()));
    }
  }
}