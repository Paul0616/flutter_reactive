import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';

class AddProductAction {
  final Product product;
  AddProductAction(this.product);
}

Cart cartReducer(Cart state, dynamic action) {
  if (action is AddProductAction) {
    print('Adding product');
    return Cart.clone(state)..add(action.product);
  }
  return state;
}
