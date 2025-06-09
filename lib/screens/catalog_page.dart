import 'package:flutter/material.dart';
import '../data/items.dart';
import '../models/item.dart';
import 'cart_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final Map<Item, int> _cart = CartPage.cartItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Каталог')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Image.asset('assets/logo.jpg', width: 50),
            title: Text(item.name),
            subtitle: Text('${item.price.toStringAsFixed(0)} руб.'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                setState(() {
                  _cart.update(item, (value) => value + 1, ifAbsent: () => 1);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Добавлено в корзину')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
