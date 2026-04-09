import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universities/feature/universities/domain/entities/university.dart';
import 'package:universities/feature/universities/presentation/providers/universities_providers.dart';
import 'package:universities/feature/universities/presentation/state/universities_state.dart';

void main() {
  group('UniversitiesNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('toggleLayout should change isGrid value', () {
      final notifier = container.read(universitiesNotifierProvider.notifier);

      expect(container.read(universitiesNotifierProvider).isGrid, false);

      notifier.toggleLayout();

      expect(container.read(universitiesNotifierProvider).isGrid, true);

      notifier.toggleLayout();

      expect(container.read(universitiesNotifierProvider).isGrid, false);
    });

    test('loadMore should append next 20 universities', () {
      final notifier = container.read(universitiesNotifierProvider.notifier);

      final universities = List.generate(
        45,
        (index) => University(
          name: 'University $index',
          country: 'Country $index',
          stateProvince: null,
          webPages: ['https://test$index.edu'],
          domains: ['test$index.edu'],
        ),
      );

      notifier.state = UniversitiesState(
        allUniversities: universities,
        visibleUniversities: universities.take(20).toList(),
        hasMore: true,
      );

      notifier.loadMore();

      final state = container.read(universitiesNotifierProvider);

      expect(state.visibleUniversities.length, 40);
      expect(state.hasMore, true);
    });

    test('loadMore should stop when all items are loaded', () {
      final notifier = container.read(universitiesNotifierProvider.notifier);

      final universities = List.generate(
        25,
        (index) => University(
          name: 'University $index',
          country: 'Country $index',
          stateProvince: null,
          webPages: ['https://test$index.edu'],
          domains: ['test$index.edu'],
        ),
      );

      notifier.state = UniversitiesState(
        allUniversities: universities,
        visibleUniversities: universities.take(20).toList(),
        hasMore: true,
      );

      notifier.loadMore();

      final state = container.read(universitiesNotifierProvider);

      expect(state.visibleUniversities.length, 25);
      expect(state.hasMore, false);
    });
  });
}
