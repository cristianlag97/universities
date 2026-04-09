import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/universities_providers.dart';
import '../widgets/universities_view.dart';

class UniversitiesPage extends ConsumerStatefulWidget {
  const UniversitiesPage({super.key});

  @override
  ConsumerState<UniversitiesPage> createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends ConsumerState<UniversitiesPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    Future.microtask(() {
      ref.read(universitiesNotifierProvider.notifier).loadUniversities();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final shouldLoadMore = position.pixels >= position.maxScrollExtent - 200;

    if (shouldLoadMore) {
      ref.read(universitiesNotifierProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(universitiesNotifierProvider);
    final notifier = ref.read(universitiesNotifierProvider.notifier);

    return UniversitiesView(
      state: state,
      scrollController: _scrollController,
      onToggleLayout: notifier.toggleLayout,
      onRetry: notifier.loadUniversities,
    );
  }
}
