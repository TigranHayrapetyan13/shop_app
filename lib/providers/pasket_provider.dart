import 'package:flutter/foundation.dart';

import '../models/product.dart';

class Basket with ChangeNotifier {
  List basket = [];

  bool select(Product pr) {
    return basket.contains(pr);
  }

  void addRmFV(Product pr) {
    if (select(pr)) {
      basket.remove(pr);
    } else {
      basket.add(pr);
    }
    // notifyListeners();
  }
}
