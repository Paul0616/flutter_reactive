import 'dart:ui';

class Product{
  final int id;
  final String name;
  final Color color;

  const Product(this.id, this.name, this.color);

  @override
  String toString() => '$name (id=$id)';

  @override
  bool operator ==(other) => other is Product && other.hashCode == hashCode;

  @override
  int get hashCode => id;


}