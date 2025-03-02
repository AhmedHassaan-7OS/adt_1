part of 'search_product_bloc.dart';

abstract class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class SearchProducts extends SearchProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}