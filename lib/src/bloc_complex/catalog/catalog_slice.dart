import 'dart:math';
import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/service/catalog_page.dart';

class CatalogSlice {
  final List<CatalogPage> _pages;

  /// The index at which this slice starts to provide [Product]s.
  final int startIndex;

  /// Whether or not this slice is the end of the catalog.
  /// Currently always `true` as our catalog is infinite.
  final bool hasNext;

  CatalogSlice(this._pages, this.hasNext)
      : startIndex = _pages.map((p) => p.startIndex).fold(0x7FFFFFFF, min);

  const CatalogSlice.empty()
      : _pages = const [],
        startIndex = 0,
        hasNext = true;

  int get endIndex =>
      startIndex + _pages.map((page) => page.endIndex).fold(-1, max);

  Product elementAt(int index) {
    for (final page in _pages) {
      if (index >= page.startIndex && index <= page.endIndex) {
        return page.products[index - page.startIndex];
      }
    }
    return null;
  }

  @override
  String toString() => 'Slice contain: ${_pages.map((e) => e.toString())}';
}
