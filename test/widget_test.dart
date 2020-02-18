// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_reactive_programming/common/models/cart.dart';
import 'package:flutter_reactive_programming/common/widgets/cart_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_reactive_programming/src/vanilla/main.dart' as vanilla;
import 'package:flutter_reactive_programming/src/value_notifier/main.dart'
    as valueNotifier;
import 'package:flutter_reactive_programming/src/scoped/main.dart' as scoped;
import 'package:flutter_reactive_programming/src/redux/main.dart' as redux;
import 'package:flutter_reactive_programming/src/bloc/main.dart' as bloc;

void main() {
  testWidgets('vanilla', (WidgetTester tester) async {
    final app = vanilla.MyApp();
    await _performSmokeTest(tester, app);
    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
  });
  testWidgets('value notifier', (WidgetTester tester) async {
    final cartObservable = valueNotifier.CartObservable(Cart());
    final app = valueNotifier.MyApp(
      cartObservable: cartObservable,
    );
    await _performSmokeTest(tester, app);
  });
  testWidgets('scoped', (WidgetTester tester) async {
    final app = scoped.MyApp();
    await _performSmokeTest(tester, app);
  });
  testWidgets('redux', (WidgetTester tester) async {
    final app = redux.MyApp();
    await _performSmokeTest(tester, app);
  });
  testWidgets('bloc', (WidgetTester tester) async {
    final app = bloc.MyApp();
    await _performSmokeTest(tester, app);
  });
}

Future _performSmokeTest(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(app);

  expect(find.text('0'), findsOneWidget);
  await tester.tap(find.byType(CartButton));
  await tester.pumpAndSettle();

  expect(find.text('Empty'), findsOneWidget);
  await tester.pageBack();
  await tester.pumpAndSettle();

  await tester.tap(find.text('SOCKS'));
  await tester.pumpAndSettle();

  expect(find.text('1'), findsOneWidget);
  await tester.tap(find.byType(CartButton));
  await tester.pumpAndSettle();

  expect(find.text('Empty'), findsNothing);
  expect(find.text('Socks'), findsOneWidget);
}
