import 'package:flutter/material.dart';
import 'package:practices/api_services/api_service.dart';
import 'package:practices/view_models/favourite_view_model.dart';
import 'package:provider/provider.dart';

import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    getProductsFun();
  }

  void getProductsFun() async {
    final result = await ApiService().getAllProducts();
    setState(() {
      products = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final fvm = Provider.of<FavouriteViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => FavouriteScreen(allProducts: products),
                    ),
                  );
                },
                child: Icon(Icons.favorite),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                final product = products[index];
                final isFav = fvm.isFavourite(product['id']);

                return Card(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.network(
                                    product['thumbnail'] ?? '',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (_, __, ___) => Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        fvm.toggleFavourite(product['id']);
                                      },
                                      child: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: isFav ? Colors.red : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              product['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
