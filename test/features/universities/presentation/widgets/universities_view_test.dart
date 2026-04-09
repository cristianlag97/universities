import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/feature/universities/presentation/state/universities_state.dart';
import 'package:universities/feature/universities/presentation/widgets/universities_view.dart';

void main() {
  group('UniversitiesView', () {
    testWidgets('shows loader when state is loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UniversitiesView(
            state: const UniversitiesState(isLoading: true),
            scrollController: ScrollController(),
            onToggleLayout: () {},
            onRetry: () async {},
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows empty state when there are no universities', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: UniversitiesView(
            state: const UniversitiesState(
              isLoading: false,
              visibleUniversities: [],
            ),
            scrollController: ScrollController(),
            onToggleLayout: () {},
            onRetry: () async {},
          ),
        ),
      );

      expect(find.text(AppStrings.noUniversitiesAvailable), findsOneWidget);
    });
  });
}
