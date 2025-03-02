import 'package:adt_1/model/product_model.dart';
import 'package:adt_1/ui/details_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // الانتقال إلى شاشة التفاصيل
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.thumbnail ?? '',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان المنتج
                  Text(
                    product.title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),

                  // سعر المنتج
                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        product.rating?.toStringAsFixed(1) ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
