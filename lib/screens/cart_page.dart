import 'package:flutter/material.dart';
import '../models/item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static final Map<Item, int> cartItems = {};

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<Item, int> get _items => CartPage.cartItems;

  double get _total => _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Корзина')),
      body: _items.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _items.entries.map((entry) {
                      final item = entry.key;
                      final count = entry.value;
                      return ListTile(
                        leading: Image.asset('assets/logo.jpg', width: 50),
                        title: Text(item.name),
                        subtitle: Text('${item.price.toStringAsFixed(0)} руб. x $count'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                _items[item] = count - 1;
                              } else {
                                _items.remove(item);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Итого: ${_total.toStringAsFixed(0)} руб.'),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _items.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Заказ оформлен!')),
                          );
                        },
                        child: const Text('Оформить заказ'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
