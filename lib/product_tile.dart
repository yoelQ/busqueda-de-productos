import 'package:flutter/material.dart';
import 'detail_page.dart';

class ProductTile extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product['thumbnail'],
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(product['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('Precio: \$${product['price']}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(product: product)),
        );
      },
    );
  }
}
