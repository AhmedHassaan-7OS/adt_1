part of 'fetch_product_bloc.dart';

sealed class FetchProductState extends Equatable {
  const FetchProductState();

  @override
  List<Object> get props => [];
}

final class FetchProductInitial extends FetchProductState {}

final class FetchProductLoading extends FetchProductState {}

final class FetchProductLoaded extends FetchProductState {
  final List<Product> products;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const FetchProductLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  FetchProductLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return FetchProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax, isLoadingMore];
}

final class FetchProductError extends FetchProductState {
  final String message;

  const FetchProductError(this.message);

  @override
  List<Object> get props => [message];
}