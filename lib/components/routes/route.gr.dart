// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i15;
import '../../screens/book/book_info/book_info_page.dart' as _i7;
import '../../screens/collections/books/books_page.dart' as _i6;
import '../../screens/collections/collection_page.dart' as _i5;
import '../../screens/home/home_page.dart' as _i3;
import '../../screens/log_in/log_in_page.dart' as _i1;
import '../../screens/profile/extra/settings/settings_page.dart'
    as _i14;
import '../../screens/profile/interactions/books/user_books_page.dart'
    as _i12;
import '../../screens/profile/interactions/collections/user_collections_page.dart'
    as _i13;
import '../../screens/profile/interactions/quotes/user_quotes_page.dart'
    as _i10;
import '../../screens/profile/interactions/reviews/user_review_page.dart'
    as _i11;
import '../../screens/profile/profile_page.dart' as _i9;
import '../../screens/search/search_page.dart' as _i8;
import '../../screens/sign_up/sign_up_page.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LogInRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LogInPage());
    },
    SignUpRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.SignUpPage());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.HomePage(args.userId, key: args.key));
    },
    CollectionsRouter.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    SearchRouter.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileRouter.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    CollectionsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.CollectionsPage());
    },
    CollectionBooksRoute.name: (routeData) {
      final args = routeData.argsAs<CollectionBooksRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.CollectionBooksPage(args.collectionId, args.collectionName,
              key: args.key));
    },
    BookInfoRoute.name: (routeData) {
      final args = routeData.argsAs<BookInfoRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.BookInfoPage(args.bookId, key: args.key));
    },
    SearchRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i8.SearchPage());
    },
    ProfileRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i9.ProfilePage());
    },
    UserQuotesRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.UserQuotesPage());
    },
    UserReviewRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i11.UserReviewPage());
    },
    UserBooksRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i12.UserBooksPage());
    },
    UserCollectionsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i13.UserCollectionsPage());
    },
    SettingsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i14.SettingsPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        _i4.RouteConfig(LogInRoute.name, path: '/login', children: [
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: LogInRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i4.RouteConfig(SignUpRoute.name, path: '/signup', children: [
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: SignUpRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i4.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i4.RouteConfig(CollectionsRouter.name,
              path: 'collections',
              parent: HomeRoute.name,
              children: [
                _i4.RouteConfig(CollectionsRoute.name,
                    path: '', parent: CollectionsRouter.name),
                _i4.RouteConfig(CollectionBooksRoute.name,
                    path: 'allBooks', parent: CollectionsRouter.name),
                _i4.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: CollectionsRouter.name),
                _i4.RouteConfig('*#redirect',
                    path: '*',
                    parent: CollectionsRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i4.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRoute.name,
              children: [
                _i4.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i4.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: SearchRouter.name),
                _i4.RouteConfig('*#redirect',
                    path: '*',
                    parent: SearchRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i4.RouteConfig(ProfileRouter.name,
              path: 'profile',
              parent: HomeRoute.name,
              children: [
                _i4.RouteConfig(ProfileRoute.name,
                    path: '', parent: ProfileRouter.name),
                _i4.RouteConfig(UserQuotesRoute.name,
                    path: 'userQuotes', parent: ProfileRouter.name),
                _i4.RouteConfig(UserReviewRoute.name,
                    path: 'userReviews', parent: ProfileRouter.name),
                _i4.RouteConfig(UserBooksRoute.name,
                    path: 'userBooks', parent: ProfileRouter.name),
                _i4.RouteConfig(UserCollectionsRoute.name,
                    path: 'userCollections', parent: ProfileRouter.name),
                _i4.RouteConfig(CollectionBooksRoute.name,
                    path: 'allBooks', parent: ProfileRouter.name),
                _i4.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: ProfileRouter.name),
                _i4.RouteConfig(SettingsRoute.name,
                    path: 'settings', parent: ProfileRouter.name),
                _i4.RouteConfig('*#redirect',
                    path: '*',
                    parent: ProfileRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i4.RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: '/home',
              fullMatch: true)
        ]),
        _i4.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.LogInPage]
class LogInRoute extends _i4.PageRouteInfo<void> {
  const LogInRoute({List<_i4.PageRouteInfo>? children})
      : super(LogInRoute.name, path: '/login', initialChildren: children);

  static const String name = 'LogInRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpRoute extends _i4.PageRouteInfo<void> {
  const SignUpRoute({List<_i4.PageRouteInfo>? children})
      : super(SignUpRoute.name, path: '/signup', initialChildren: children);

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required int userId, _i15.Key? key, List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final int userId;

  final _i15.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class CollectionsRouter extends _i4.PageRouteInfo<void> {
  const CollectionsRouter({List<_i4.PageRouteInfo>? children})
      : super(CollectionsRouter.name,
            path: 'collections', initialChildren: children);

  static const String name = 'CollectionsRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class SearchRouter extends _i4.PageRouteInfo<void> {
  const SearchRouter({List<_i4.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProfileRouter extends _i4.PageRouteInfo<void> {
  const ProfileRouter({List<_i4.PageRouteInfo>? children})
      : super(ProfileRouter.name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i5.CollectionsPage]
class CollectionsRoute extends _i4.PageRouteInfo<void> {
  const CollectionsRoute() : super(CollectionsRoute.name, path: '');

  static const String name = 'CollectionsRoute';
}

/// generated route for
/// [_i6.CollectionBooksPage]
class CollectionBooksRoute extends _i4.PageRouteInfo<CollectionBooksRouteArgs> {
  CollectionBooksRoute(
      {required int collectionId,
      required String collectionName,
      _i15.Key? key})
      : super(CollectionBooksRoute.name,
            path: 'allBooks',
            args: CollectionBooksRouteArgs(
                collectionId: collectionId,
                collectionName: collectionName,
                key: key));

  static const String name = 'CollectionBooksRoute';
}

class CollectionBooksRouteArgs {
  const CollectionBooksRouteArgs(
      {required this.collectionId, required this.collectionName, this.key});

  final int collectionId;

  final String collectionName;

  final _i15.Key? key;

  @override
  String toString() {
    return 'CollectionBooksRouteArgs{collectionId: $collectionId, collectionName: $collectionName, key: $key}';
  }
}

/// generated route for
/// [_i7.BookInfoPage]
class BookInfoRoute extends _i4.PageRouteInfo<BookInfoRouteArgs> {
  BookInfoRoute({required int bookId, _i15.Key? key})
      : super(BookInfoRoute.name,
            path: 'bookInfo',
            args: BookInfoRouteArgs(bookId: bookId, key: key));

  static const String name = 'BookInfoRoute';
}

class BookInfoRouteArgs {
  const BookInfoRouteArgs({required this.bookId, this.key});

  final int bookId;

  final _i15.Key? key;

  @override
  String toString() {
    return 'BookInfoRouteArgs{bookId: $bookId, key: $key}';
  }
}

/// generated route for
/// [_i8.SearchPage]
class SearchRoute extends _i4.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i9.ProfilePage]
class ProfileRoute extends _i4.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i10.UserQuotesPage]
class UserQuotesRoute extends _i4.PageRouteInfo<void> {
  const UserQuotesRoute() : super(UserQuotesRoute.name, path: 'userQuotes');

  static const String name = 'UserQuotesRoute';
}

/// generated route for
/// [_i11.UserReviewPage]
class UserReviewRoute extends _i4.PageRouteInfo<void> {
  const UserReviewRoute() : super(UserReviewRoute.name, path: 'userReviews');

  static const String name = 'UserReviewRoute';
}

/// generated route for
/// [_i12.UserBooksPage]
class UserBooksRoute extends _i4.PageRouteInfo<void> {
  const UserBooksRoute() : super(UserBooksRoute.name, path: 'userBooks');

  static const String name = 'UserBooksRoute';
}

/// generated route for
/// [_i13.UserCollectionsPage]
class UserCollectionsRoute extends _i4.PageRouteInfo<void> {
  const UserCollectionsRoute()
      : super(UserCollectionsRoute.name, path: 'userCollections');

  static const String name = 'UserCollectionsRoute';
}

/// generated route for
/// [_i14.SettingsPage]
class SettingsRoute extends _i4.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings');

  static const String name = 'SettingsRoute';
}
