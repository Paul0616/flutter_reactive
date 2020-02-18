// A class that mimics a network-backed service.
import 'dart:math';
import 'dart:ui';

import 'package:flutter_reactive_programming/common/models/product.dart';
import 'package:flutter_reactive_programming/src/bloc_complex/service/catalog_page.dart';

class CatalogService{
  static int productPerPage = 10;

  static int networkDelay = 500;

  Future<CatalogPage> requestPage(int offset) async {
    await Future.delayed(Duration(milliseconds: networkDelay));

    final random = Random(offset);
    final products = List.generate(productPerPage, (index){
      final id = random.nextInt(0xffff);
      final color = Color(0xFF000000 | random.nextInt(0xFFFFFF));
      return Product(id, 'Product $id (#${offset+index})', color);
    });
    return CatalogPage(products, offset);
  }
}