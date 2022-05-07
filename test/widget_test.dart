// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
<<<<<<< HEAD
// utility that Flutter provides. For example, you can send tap and scroll
=======
// utility in the flutter_test package. For example, you can send tap and scroll
>>>>>>> d02614a7c11b6bb036c186e125cf629b8caeffea
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

<<<<<<< HEAD
import 'package:practice/main.dart';
=======
import 'package:gnumap/main.dart';
>>>>>>> d02614a7c11b6bb036c186e125cf629b8caeffea

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
