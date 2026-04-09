import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universities/core/constants/app_spacing.dart';
import 'package:universities/core/constants/app_strings.dart';
import 'package:universities/core/router/routes.dart';
import 'package:universities/feature/universities/presentation/state/universities_state.dart';
import 'package:universities/feature/universities/presentation/widgets/empty_state_view.dart';
import 'package:universities/feature/universities/presentation/widgets/layout_toggle_button.dart';
import 'package:universities/feature/universities/presentation/widgets/load_more_loader.dart';
import 'package:universities/feature/universities/presentation/widgets/university_card.dart';
import 'package:universities/feature/universities/presentation/widgets/university_grid_tile.dart';

class UniversitiesView extends StatelessWidget {
  final UniversitiesState state;
  final ScrollController scrollController;
  final VoidCallback onToggleLayout;
  final Future<void> Function() onRetry;

  const UniversitiesView({
    super.key,
    required this.state,
    required this.scrollController,
    required this.onToggleLayout,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.universitiesTitle),
        actions: [
          LayoutToggleButton(isGrid: state.isGrid, onPressed: onToggleLayout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Builder(
          builder: (_) {
            if (state.isLoading) {
              return LoadMoreLoader();
            }

            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error!),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: onRetry,
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              );
            }

            if (state.visibleUniversities.isEmpty) {
              return const EmptyStateView(
                message: AppStrings.noUniversitiesAvailable,
              );
            }

            if (state.isGrid) {
              return RefreshIndicator(
                onRefresh: onRetry,
                child: GridView.builder(
                  controller: scrollController,
                  itemCount:
                      state.visibleUniversities.length +
                      (state.isLoadingMore ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    if (index >= state.visibleUniversities.length) {
                      return const LoadMoreLoader();
                    }

                    final university = state.visibleUniversities[index];

                    return UniversityGridTile(
                      university: university,
                      onTap: () {
                        context.push(
                          PAGES.detail.screenPath,
                          extra: university,
                        );
                      },
                    );
                  },
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: onRetry,
              child: ListView.separated(
                controller: scrollController,
                itemCount:
                    state.visibleUniversities.length +
                    (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  if (index >= state.visibleUniversities.length) {
                    return const LoadMoreLoader();
                  }

                  final university = state.visibleUniversities[index];

                  return UniversityCard(
                    university: university,
                    onTap: () {
                      context.push(PAGES.detail.screenPath, extra: university);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
