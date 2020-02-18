import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/catalog.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_page.dart';
import 'package:flutter_reactive_programming/common/widgets/product_square.dart';
import 'package:flutter_reactive_programming/common/widgets/theme.dart';
import 'package:flutter_reactive_programming/src/bloc/bloc_cart_page.dart';
import 'package:flutter_reactive_programming/src/bloc/cart_bloc.dart';
import 'package:flutter_reactive_programming/src/bloc/cart_provider.dart';
import 'package:rxdart/subjects.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Cart cart = Cart();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc',
      theme: appTheme,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        BlocCartPage.routeName: (context) => BlocCartPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc'),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            builder: (context, snapshot) => CartButton(
              itemCount: snapshot.data,
              onPressed: () {
                Navigator.of(context).pushNamed(BlocCartPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: catalog.products.map((product) {
            return ProductSquare(
              product: product,
              onTap: () {
                cartBloc.cartAddition.add(CartAddition(product));
              },
            );
          }).toList()),
    );
  }
}
