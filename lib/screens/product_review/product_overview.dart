import 'package:flutter/material.dart';
import 'package:reviewapp/model/product.dart';

class ProductOverview extends StatelessWidget {
  final Product product;
  final String category;
  ProductOverview({@required this.product, @required this.category});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var boldTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      // color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.width * 0.3,
            width: size.width * 0.3,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(product.imageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width * 0.45,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: boldTextStyle,
                ),
                Text(
                  'Rating: ${product.rating.toString()} (${product.votes})',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: (product.rating > 4)
                        ? Colors.green
                        : (product.rating > 3)
                            ? Colors.blue
                            : (product.rating > 2)
                                ? Colors.orange
                                : Colors.red,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Price: ${product.price}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Category: $category',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
