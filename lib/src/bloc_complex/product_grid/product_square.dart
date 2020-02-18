import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart_item.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/common/utils/is_dark.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/product_grid/product_square_bloc.dart';

/// In this version of [ProductSquare], the widget must be a [StatefulWidget]
/// because it has a [ProductSquareBloc] that it needs to dispose of
/// when it's no longer needed.
class ProductSquare extends StatefulWidget {
  final Product product;

  final Stream<List<CartItem>> itemsStream;

  final GestureTapCallback onTap;

  const ProductSquare(
      {Key key, @required this.product, @required this.itemsStream, this.onTap})
      : super(key: key);

  @override
  _ProductSquareState createState() => _ProductSquareState();
}

class _ProductSquareState extends State<ProductSquare> {
  /// The business logic component for the [ProductSquare] widget.
  ///
  /// In our sample this might be overkill, but in a real app the widget will
  /// get much more complicated (fetching images, availability, favorite status,
  /// etc.).
  ProductSquareBloc _bloc;

  /// Because we're piping an output of one BLoC into an input of another,
  /// we need to hold the subscription object in order to cancel it later.
  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.product.color,
      child: InkWell(
        onTap: widget.onTap,
        child: StreamBuilder<bool>(
          stream: _bloc.isInCart,
          initialData: _bloc.isInCart.value,
          builder: (context, snapshot) => _createText(snapshot.data),
        ),
      ),
    );
  }

  Widget _createText(bool isInCart) {
    return Center(
      child: Text(
        widget.product.name,
        style: TextStyle(
          color: isDark(widget.product.color) ? Colors.white : Colors.black,
          decoration: isInCart ? TextDecoration.underline : null,
        ),
      ),
    );
  }

  /// Remember: widgets can change from above the [State] at the framework's
  /// discretion. We need to make sure we always update the [State]
  /// to reflect the [StatefulWidget].
  ///
  /// Here, we're disposing of the old [_bloc] and creating a new one.
  @override
  void didUpdateWidget(ProductSquare oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createBloc();
  }

  void _disposeBloc() {
    _subscription.cancel();
    _bloc.dispose();
  }

  void _createBloc() {
    _bloc = ProductSquareBloc(widget.product);
    _subscription = widget.itemsStream.listen(_bloc.cartItem.add);
  }
}
