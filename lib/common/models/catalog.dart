import 'dart:collection';
import 'dart:ui';

import 'package:flutter_reactive_programming/common/models/product.dart';

final Catalog catalog = fetchCatalogSync();

Catalog fetchCatalogSync() => Catalog._sample();

class Catalog {
  static const List<Product> _sampleProducts = const <Product>[
    const Product(42, "Sweater", const Color(0xFF536DFE)),
    const Product(1024, "Socks", const Color(0xFFFFD500)),
    const Product(1337, "Shawl", const Color(0xFF1CE8B5)),
    const Product(123, "Jacket", const Color(0xFFFF6C00)),
    const Product(201805, "Hat", const Color(0xFF574DDD)),
    const Product(128, "Hoodie", const Color(0xFFABD0F2)),
    const Product(321, "Tuxedo", const Color(0xFF8DA0FC)),
    const Product(1003, "Shirt", const Color(0xFF1CE8B5)),
  ];

  final List<Product> _products;

  Catalog._sample() : _products = _sampleProducts;

  Catalog.empty() : _products = [];

  UnmodifiableListView<Product> get products =>
      UnmodifiableListView<Product>(_products);
}
