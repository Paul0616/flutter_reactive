import 'dart:async';

import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/cart_item.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final Cart _cart = Cart();

  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>.seeded(<CartItem>[]);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  final StreamController<CartAddition> _cartAdditionalController =
      StreamController<CartAddition>();

  CartBloc() {

    _cartAdditionalController.stream.listen((addition) {

      int currentCount = _cart.itemCount;
      _cart.add(addition.product, addition.count);
      _items.add(_cart.items);
      int updatedCount = _cart.itemCount;
      if (updatedCount != currentCount) {
        _itemCount.add(updatedCount);
      }
    });
  }

  Sink<CartAddition> get cartAddition => _cartAdditionalController.sink;
  Stream<int> get itemCount => _itemCount.stream;
  Stream<List<CartItem>> get items => _items.stream;

  void dispose() {
    _itemCount.close();
    _items.close();
    _cartAdditionalController.close();
  }
}

class CartAddition {
  final Product product;
  final int count;

  CartAddition(this.product, [this.count = 1]);
}
