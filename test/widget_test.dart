import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tiebreaker_app/screens/home_screen.dart';
import 'package:tiebreaker_app/services/decision_service.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('home screen shows input and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => DecisionService(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('Tiebreaker App'), findsOneWidget);
    expect(find.text('Help me Decide!'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
