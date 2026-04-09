part of 'routes.dart';

enum PAGES { home, detail }

extension AppScreenExtension on PAGES {
  String get screenPath {
    switch (this) {
      case PAGES.home:
        return "/";
      case PAGES.detail:
        return "/university-detail";
    }
  }

  String get screenName {
    switch (this) {
      case PAGES.home:
        return "HOME";
      case PAGES.detail:
        return "DETAIL";
    }
  }
}
