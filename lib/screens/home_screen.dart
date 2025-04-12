import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practices/api_services/api_service.dart';

import 'favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  List<dynamic> products = [];
  List<bool> favouriteList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsFun();
  }

  void getProductsFun() async {
    final result = await ApiService().getAllProducts();
    setState(() {
      products = result;
      favouriteList = List.generate(products.length, (_) => false);
    });
  }

  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
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
                        final favProducts = <dynamic>[];
                        for (int i = 0; i < products.length; i++) {
                          if (favouriteList[i]) {
                            favProducts.add(products[i]);
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => FavouriteScreen(
                                    favouriteProducts: favProducts)));
                      },
                      child: Icon(Icons.favorite)))),
          Expanded(
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemBuilder: (context, index) {
                  // Color bgColor = colors[index % colors.length];
                  final product = products[index];
                  log('Rendering: ${product['title']}');
                  return Card(
                    child: Container(
                      // color: bgColor,
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
                                          setState(() {
                                            favouriteList[index] =
                                                !favouriteList[index];
                                          });
                                          log('favouriteList: ${favouriteList[index]}');
                                        },
                                        child: Icon(
                                          favouriteList[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: favouriteList[index]
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              // 'Item $index',
                              product['title'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      )),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
