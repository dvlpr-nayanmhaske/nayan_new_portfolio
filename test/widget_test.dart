import 'package:flutter_test/flutter_test.dart';
import 'package:nayan_portfolio_updated/main.dart';

void main() {
  testWidgets('PortfolioApp renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.byType(PortfolioApp), findsOneWidget);
  });
}
