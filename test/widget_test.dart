import 'package:fitjourney/app.dart';
import 'package:fitjourney/core/constants/app_strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders home screen with title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: FitJourneyApp()));

    expect(find.text(AppStrings.appName), findsWidgets);
    expect(find.text(AppStrings.home), findsOneWidget);
    expect(find.text(AppStrings.exercises), findsOneWidget);
    expect(find.text(AppStrings.history), findsOneWidget);
    expect(find.text(AppStrings.progress), findsOneWidget);
  });
}
