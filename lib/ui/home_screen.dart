import 'package:adt_1/bloc/bloc/fetch_product_bloc.dart';
import 'package:adt_1/ui/product_card.dart';
import 'package:adt_1/ui/product_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Products'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: BlocConsumer<FetchProductBloc, FetchProductState>(
        listener: (context, state) {
          if (state is FetchProductLoaded && state.hasReachedMax) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No more products available.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FetchProductLoaded) {
            return AnimationLimiter(
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount:
                    state.products.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.products.length) {
                    if (!state.hasReachedMax) {
                      context
                          .read<FetchProductBloc>()
                          .add(FetchProducts(limit: state.products.length));
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  final product = state.products[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: Duration(milliseconds: 500),
                    columnCount: 2,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: ProductCard(product: product),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is FetchProductError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No products found'));
        },
      ),
    );
  }
}

