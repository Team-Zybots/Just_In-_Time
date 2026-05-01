import 'package:flutter_test/flutter_test.dart';

import 'package:admin_web_dashboard/main.dart';

void main() {
  testWidgets('Admin Dashboard UI loads correctly', (WidgetTester tester) async {
    // 1. Build our app and trigger a frame.
    // We replaced MyApp() with our new AdminDashboardApp()
    await tester.pumpWidget(const AdminDashboardApp());

    // 2. Verify that the Navigation Rail is present by looking for its labels
    expect(find.text('Live Queue'), findsOneWidget);
    expect(find.text('Doctors'), findsOneWidget);
    expect(find.text('Payments'), findsOneWidget);

    // 3. Verify that the initial screen loads the placeholder text
    expect(find.text('Live Queue Module'), findsOneWidget);

    // 4. Test clicking a different tab in the sidebar
    await tester.tap(find.text('Doctors'));
    await tester.pump(); // Rebuild the UI after the tap

    // 5. Verify the screen changed
    expect(find.text('Manage Doctors Module'), findsOneWidget);
  });
}