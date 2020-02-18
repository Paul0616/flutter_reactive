import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/catalog.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_page.dart';
import 'package:flutter_reactive_programming/common/widgets/product_square.dart';
import 'package:flutter_reactive_programming/common/widgets/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Cart cart = Cart();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vanilla',
      theme: appTheme,
      home: MyHomePage(cart: cart),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage(cart),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Cart cart;

  MyHomePage({
    Key key,
    @required this.cart,
  }) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vanilla'),
        actions: <Widget>[
          CartButton(
            itemCount: widget.cart.itemCount,
            onPressed: () {
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: catalog.products.map((product) {
            return ProductSquare(
              product: product,
              onTap: () {
                setState(() {
                  widget.cart.add(product);
                });
              },
            );
          }).toList()),
    );
  }
}
