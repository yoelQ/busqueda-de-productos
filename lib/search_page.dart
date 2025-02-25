import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tarea_api/history_page.dart';
import 'package:http/http.dart' as http;
import 'product_tile.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _products = [];

  Future<void> _searchProducts() async {
    if (_searchController.text.isEmpty) return;
    final url = 'https://api.mercadolibre.com/sites/MLA/search?q=${_searchController.text}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _products = json.decode(response.body)['results'];
      });
    }
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Buscar Productos'),
    actions: [
    IconButton(
      icon: Icon(Icons.history),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryPage()),
        );
      },
    ),
  ],
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(labelText: 'Buscar producto'),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: _searchProducts)
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];
              return ProductTile(product: product);
            },
          ),
        ),
      ],
    ),
  );
}
}