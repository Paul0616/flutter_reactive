import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/common/utils/is_dark.dart';

class ProductSquare extends StatelessWidget {
  final Product product;
  final GestureTapCallback onTap;

  const ProductSquare({
    Key key,
    @required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: product.color,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            product.name.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark(product.color) ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
