// Basic smoke test for DOT Hours Tracker app.
import 'package:flutter_test/flutter_test.dart';

import 'package:dot_hours_tracker/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const DotHoursTrackerApp());
    await tester.pump();
    expect(find.byType(HoursTrackerHome), findsOneWidget);
  });
}
