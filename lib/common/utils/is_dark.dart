
import 'dart:ui';

bool isDark(Color color){
  final luminance = (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue);
  return luminance < 150;
}