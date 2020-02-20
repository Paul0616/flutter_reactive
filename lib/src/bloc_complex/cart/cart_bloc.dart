import 'dart:async';

import 'package:flutter_reactive_programming/common/models/cart_item.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/service/cart.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  final _cart = CartService();

  final BehaviorSubject<List<CartItem>> _items =
      BehaviorSubject<List<CartItem>>.seeded(<CartItem>[]);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);

  final StreamController<CartAddition> _cartAdditionalController =
      StreamController<CartAddition>();

  CartBloc() {
    _cartAdditionalController.stream.listen((addition) {
      _cart.add(addition.product, addition.count);
      _items.add(_cart.items);
      _itemCount.add(_cart.itemCount);
    });
  }

  Sink<CartAddition> get cartAddition => _cartAdditionalController.sink;

  ValueStream<int> get itemCount => _itemCount.distinct().shareValueSeeded(0);

  ValueStream<List<CartItem>> get items => _items.stream;

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
