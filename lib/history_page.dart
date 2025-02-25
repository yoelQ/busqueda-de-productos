import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('history') ?? [];
    setState(() {
      _history = history.map((item) => json.decode(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historial de Productos')),
      body: _history.isEmpty
          ? Center(child: Text('No hay productos recientes'))
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final product = _history[index];
                return ListTile(
                  leading: Image.network(product['thumbnail']),
                  title: Text(product['title']),
                  subtitle: Text('Precio: \$${product['price']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
