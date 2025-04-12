import 'dart:developer';

import 'package:flutter/material.dart';

class FavouriteViewModel with ChangeNotifier {
  final Set<int> favouriteIndexes = {};

  void toggleFavourite(int index) {
    if (favouriteIndexes.contains(index)) {
      favouriteIndexes.remove(index);
    } else {
      favouriteIndexes.add(index);
    }
    notifyListeners(); // notifies all listening widgets to rebuild
    log('favouriteList: ${favouriteIndexes}');
  }

  void removeByIndex(int index) {
    favouriteIndexes.remove(index);
    notifyListeners();
  }

  bool isFavourite(int index) => favouriteIndexes.contains(index);
}
