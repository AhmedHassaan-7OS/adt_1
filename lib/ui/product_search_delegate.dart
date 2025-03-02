import 'package:adt_1/bloc/bloc/search_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text('Enter a search term'));
    }

    context.read<SearchProductBloc>().add(SearchProducts(query));

    return BlocBuilder<SearchProductBloc, SearchProductState>(
      builder: (context, state) {
        if (state is SearchProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SearchProductLoaded) {
          final products = state.products;
          if (products.isEmpty) {
            return Center(child: Text('No results found'));
          }
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(product.thumbnail ?? ''),
                title: Text(product.title ?? 'No Title'),
                subtitle: Text('\$${product.price ?? 'N/A'}'),
                onTap: () {
                  close(context, product.title ?? '');
                },
              );
            },
          );
        } else if (state is SearchProductError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text('Search for products'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Start typing to search'));
  }
}
