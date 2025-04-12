import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  final List<dynamic> favouriteProducts;

  const FavouriteScreen({super.key, required this.favouriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: ListView.builder(
        itemCount: favouriteProducts.length,
        itemBuilder: (context, index) {
          final product = favouriteProducts[index];
          return ListTile(
            leading: Image.network(
              product['thumbnail'] ?? '',
              width: 50,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
            ),
            title: Text(product['title']),
          );
        },
      ),
    );
  }
}
