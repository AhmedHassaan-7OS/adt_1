part of 'fetch_product_bloc.dart';

abstract class FetchProductEvent extends Equatable {
  const FetchProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends FetchProductEvent {
  final int skip;
  final int limit;

  const FetchProducts({this.skip = 0, this.limit = 20});

  @override
  List<Object> get props => [skip, limit];
}