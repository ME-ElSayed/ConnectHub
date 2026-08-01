import 'package:flutter_test/flutter_test.dart';

import 'package:connect_hub/main.dart';

void main() {
  testWidgets('Splash screen shows brand content', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('ConnectHub'), findsOneWidget);
    expect(find.text('Share, Connect, and Discover.'), findsOneWidget);
    expect(find.text('Loading your world\u2026'), findsOneWidget);
  });
}
