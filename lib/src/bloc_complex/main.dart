import 'package:flutter/material.dart';


import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';

import 'package:flutter_reactive_programming/common/widgets/theme.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/cart/bloc_cart_page.dart';

import 'package:flutter_reactive_programming/src/bloc_complex/cart/cart_bloc.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/cart/cart_provider.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/catalog/catalog_bloc.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/product_grid/product_grid.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/service/catalog.dart';

void main() {
  final catalogService = CatalogService();

  final catalog = CatalogBloc(catalogService);
  final cart = CartBloc();
  runApp(MyApp(catalog, cart));
}

class MyApp extends StatelessWidget {
  final CatalogBloc catalog;
  final CartBloc cart;

  MyApp(this.catalog, this.cart);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CatalogProvider(
      catalog: catalog,
      child: CartProvider(
        cartBloc: cart,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bloc Complex',
          theme: appTheme,
          home: MyHomePage(),
          routes: <String, WidgetBuilder>{
            BlocCartPage.routeName: (context) => BlocCartPage(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Complex'),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            initialData: cartBloc.itemCount.value,
            builder: (context, snapshot) => CartButton(
              itemCount: snapshot.data,
              onPressed: () {
                Navigator.of(context).pushNamed(BlocCartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
