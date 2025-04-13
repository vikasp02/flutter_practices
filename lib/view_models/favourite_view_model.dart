import 'package:flutter/material.dart';

class FavouriteViewModel with ChangeNotifier {
  final Set<int> favouriteIds = {};

  void toggleFavourite(int id) {
    if (favouriteIds.contains(id)) {
      favouriteIds.remove(id);
    } else {
      favouriteIds.add(id);
    }
    notifyListeners();
  }

  void removeById(int id) {
    favouriteIds.remove(id);
    notifyListeners();
  }

  bool isFavourite(int id) => favouriteIds.contains(id);
}
