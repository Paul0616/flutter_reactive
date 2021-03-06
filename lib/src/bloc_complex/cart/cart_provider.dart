import 'package:flutter/widgets.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/cart/cart_bloc.dart';

class CartProvider extends InheritedWidget {
  final CartBloc cartBloc;

  CartProvider({Key key, CartBloc cartBloc, Widget child})
      : cartBloc = cartBloc ?? CartBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CartBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>().cartBloc;
}