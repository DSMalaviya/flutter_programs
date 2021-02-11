import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    print('toggle favourite called');
    final oldStatus = isFavourite;
    isFavourite = (!isFavourite);
    notifyListeners();
    final url =
        'https://myshop-e0cb4-default-rtdb.firebaseio.com/userFavorites/${userId}/${id}.json?auth=${token}';

    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      print('request sent');
      if (response.statusCode >= 400) {
        print('error');
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
