import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/catalog.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_page.dart';
import 'package:flutter_reactive_programming/common/widgets/product_square.dart';
import 'package:flutter_reactive_programming/common/widgets/theme.dart';

void main() {
  final CartObservable cartObservable = CartObservable(Cart());
  runApp(MyApp(
    cartObservable: cartObservable,
  ));
}

class CartObservable extends ValueNotifier<Cart> {
  CartObservable(Cart value) : super(value);

  void add(Product product) {
    value.add(product);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final CartObservable cartObservable;

  const MyApp({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Value Notifier',
      theme: appTheme,
      home: MyHomePage(
        cartObservable: cartObservable,
      ),
      routes: <String, WidgetBuilder>{
        CartPage.routeName: (context) => CartPage(cartObservable.value),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CartObservable cartObservable;

  MyHomePage({
    Key key,
    @required this.cartObservable,
  }) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Notifier'),
        actions: <Widget>[
          CartButton(
            itemCount: widget.cartObservable.value.itemCount,
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
                widget.cartObservable.add(product);
              },
            );
          }).toList()),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.cartObservable.addListener(myListener);
  }

  void myListener() {
    setState(() {
      //Nothing
    });
  }
}
