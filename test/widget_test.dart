import 'package:flutter_test/flutter_test.dart';
import 'package:autify_web/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AutifyWebApp());
    // Verify the app renders without crashing
    expect(find.byType(AutifyWebApp), findsOneWidget);
  });
}
