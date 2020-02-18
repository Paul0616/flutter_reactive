import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/models/cart_item.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: StoreConnector<Cart, List<CartItem>>(
        converter: (store) => store.state.items,
        builder: (context, items) {
          if (items.isEmpty)
            return Center(
                child:
                    Text('Empty', style: Theme.of(context).textTheme.display1));
          return ListView.builder(
            itemBuilder: (context, index) {
              return ItemTile(
                item: items[index],
              );
            },
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
