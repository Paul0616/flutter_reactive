import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/catalog.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_reactive_programming/common/widgets/product_square.dart';
import 'package:flutter_reactive_programming/common/widgets/theme.dart';
import 'package:flutter_reactive_programming/src/redux/redux_cart_page.dart';
import 'package:flutter_reactive_programming/src/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<Cart>(cartReducer, initialState: Cart());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<Cart>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redux',
        theme: appTheme,
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          CartPage.routeName: (context) => CartPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux'),
        actions: <Widget>[
          StoreConnector<Cart, int>(
            builder: (context, count) => CartButton(
              itemCount: count,
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
            converter: (store) => store.state.itemCount,
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: catalog.products.map((product) {
            return new StoreConnector<Cart, Function(Product)>(
              builder: (context, callback) => ProductSquare(
                product: product,
                onTap: () {
                  callback(product);
                },
              ),
              converter: (store) =>
                  (product) => store.dispatch(AddProductAction(product)),
            );
          }).toList()),
    );
  }
}
