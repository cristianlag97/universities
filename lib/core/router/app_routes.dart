part of 'routes.dart';

class AppRoutes {
  AppRoutes._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: PAGES.home.screenPath,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: PAGES.home.screenPath,
        name: PAGES.home.screenName,
        builder: (context, state) => const UniversitiesPage(),
      ),
      GoRoute(
        path: PAGES.detail.screenPath,
        name: PAGES.detail.screenName,
        builder: (context, state) {
          final university = state.extra as University;
          return UniversityDetailPage(university: university);
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
