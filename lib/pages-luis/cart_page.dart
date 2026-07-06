import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../menu-jesus/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, _) {
        if (cart.items.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No hay productos en el carrito')),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Carrito')),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final product = cart.items[index];

              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => cart.removeProduct(product),
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
      },
    );
  }
}
