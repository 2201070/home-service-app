import 'package:flutter_test/flutter_test.dart';
import 'package:home_services/app/app.dart';

void main() {
  testWidgets('HomeServeApp loads dashboard smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HomeServeApp());

    // Verify that the greeting message is displayed.
    expect(find.text('Good morning'), findsOneWidget);
  });
}
