import 'src/vanilla/main.dart' as vanilla;
import 'src/value_notifier/main.dart' as value_notifier;

void main() {
  final flavor = Architecture.vanilla;
  print('\n\n======== Running: $flavor ========\n\n');

  switch (flavor){

    case Architecture.vanilla:
      vanilla.main();
      break;
    case Architecture.valueNotifier:
      value_notifier.main();
      break;
  }
}

enum Architecture{
  vanilla,
  valueNotifier,
}
