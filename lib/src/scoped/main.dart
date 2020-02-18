import 'package:flutter/material.dart';

import 'package:flutter_reactive_programming/common/models/catalog.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_reactive_programming/common/widgets/product_square.dart';
import 'package:flutter_reactive_programming/common/widgets/theme.dart';
import 'package:flutter_reactive_programming/src/scoped/model.dart';
import 'package:flutter_reactive_programming/src/scoped/scoped_cart_page.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //final Cart cart = Cart();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scoped Model',
        theme: appTheme,
        home: CatalogHomePage(),
        routes: <String, WidgetBuilder>{
          CartPage.routeName: (context) => CartPage(),
        },
      ),
    );
  }
}

class CatalogHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scoped Model'),
        actions: <Widget>[
          ScopedModelDescendant<CartModel>(
            builder: (context, child, model) => CartButton(
              itemCount: model.itemCount,
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: catalog.products.map((product) {
            return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) => ProductSquare(
                product: product,
                onTap: () {
                  model.add(product);
                },
              ),
            );
          }).toList()),
    );
  }
}
