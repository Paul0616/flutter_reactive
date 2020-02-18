import 'src/vanilla/main.dart' as vanilla;
import 'src/value_notifier/main.dart' as value_notifier;
import 'src/scoped/main.dart' as scoped;
import 'src/redux/main.dart' as redux;

void main() {
  final flavor = Architecture.redux;
  print('\n\n======== Running: $flavor ========\n\n');

  switch (flavor) {
    case Architecture.vanilla:
      vanilla.main();
      break;
    case Architecture.valueNotifier:
      value_notifier.main();
      break;
    case Architecture.scoped:
      scoped.main();
      break;
    case Architecture.redux:
      redux.main();
      break;
  }
}

enum Architecture {
  vanilla,
  valueNotifier,
  scoped,
  redux,
}
