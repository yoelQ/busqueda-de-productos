import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  final dynamic product;

  DetailPage({required this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _saveToHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('history') ?? [];
    String productInfo = json.encode(widget.product);

    if (!history.contains(productInfo)) {
      if (history.length >= 5) {
        history.removeAt(0);
      }
      history.add(productInfo);
      await prefs.setStringList('history', history);
    }
  }

  @override
  void initState() {
    super.initState();
    _saveToHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product['title'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product['thumbnail'], height: 200),
            SizedBox(height: 16),
            Text(widget.product['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Precio: \$${widget.product['price']}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('ID del Producto: ${widget.product['id']}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}