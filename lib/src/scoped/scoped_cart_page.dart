import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.items == null || model.items.isEmpty) {
          return Center(
            child: Text('Empty', style: Theme.of(context).textTheme.display1),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) => ItemTile(item: model.items[index]),
          itemCount: model.items.length,
        );
      }),
    );
  }
}
