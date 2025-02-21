import 'package:flutter/material.dart';
import '../model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.thumbnail != null) Image.network(product.thumbnail!),
            SizedBox(height: 16),
            Card(
                child: Text(product.description ?? 'No description available')),
            SizedBox(height: 16),
            Card(
                child: Text(
                    'Price: \$${product.price?.toStringAsFixed(2) ?? 'N/A'}')),
            Card(
                child: Text(
                    'Rating: ${product.rating?.toStringAsFixed(1) ?? 'N/A'}')),
            Card(child: Text('Stock: ${product.stock?.toString() ?? 'N/A'}')),
            MaterialButton(
              onPressed: () {},
              color: Colors.red,
              minWidth: 200,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [Text("buy!!"), Icon(Icons.shopping_bag_outlined)],
              ),
            )
          ],
        ),
      ),
    );
  }
}
