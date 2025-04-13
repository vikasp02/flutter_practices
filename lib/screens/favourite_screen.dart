import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practices/view_models/favourite_view_model.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  final List<dynamic> allProducts;

  const FavouriteScreen({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    final fvm = Provider.of<FavouriteViewModel>(listen: true, context);

    final favProducts =
        allProducts.where((product) => fvm.isFavourite(product['id'])).toList();
    log('Rebuilt');
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: favProducts.isEmpty
          ? Center(child: Text('No favourites yet!'))
          : ListView.builder(
              itemCount: favProducts.length,
              itemBuilder: (context, index) {
                final product = favProducts[index];

                return ListTile(
                  leading: Image.network(
                    product['thumbnail'] ?? '',
                    width: 50,
                    errorBuilder: (_, __, ___) => Icon(Icons.broken_image),
                  ),
                  title: Text(
                    product['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      fvm.removeById(product['id']);
                    },
                    child: Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
