// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i25;
import '../../screens/book/book_info/book_info_page.dart' as _i8;
import '../../screens/book_club/book_club_info/book_club_info_page.dart'
    as _i11;
import '../../screens/book_club/book_clubs_page.dart' as _i10;
import '../../screens/book_club/event_info/event_info_page.dart'
    as _i12;
import '../../screens/book_club/members/members_page.dart' as _i14;
import '../../screens/book_club/reviews/event_reviews_page.dart'
    as _i13;
import '../../screens/collections/books/books_page.dart' as _i7;
import '../../screens/collections/collection_page.dart' as _i6;
import '../../screens/home/home_page.dart' as _i4;
import '../../screens/log_in/log_in_page.dart' as _i2;
import '../../screens/profile/components/top_10/top_10_page.dart'
    as _i21;
import '../../screens/profile/extra/settings/settings_page.dart'
    as _i20;
import '../../screens/profile/interactions/achievements/achievements_page.dart'
    as _i23;
import '../../screens/profile/interactions/books/user_books_page.dart'
    as _i18;
import '../../screens/profile/interactions/collections/user_collections_page.dart'
    as _i19;
import '../../screens/profile/interactions/events/events_page.dart'
    as _i24;
import '../../screens/profile/interactions/quotes/user_quotes_page.dart'
    as _i16;
import '../../screens/profile/interactions/reviews/user_review_page.dart'
    as _i17;
import '../../screens/profile/interactions/statistics/statistics_page.dart'
    as _i22;
import '../../screens/profile/profile_page.dart' as _i15;
import '../../screens/search/search_page.dart' as _i9;
import '../../screens/sign_up/sign_up_page.dart' as _i3;
import '../../screens/splash/splash_screen.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i25.GlobalKey<_i25.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LogInRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LogInPage());
    },
    SignUpRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.SignUpPage());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.HomePage(args.userId, key: args.key));
    },
    CollectionsRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    SearchRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    BookClubsRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ProfileRouter.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    CollectionsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.CollectionsPage());
    },
    CollectionBooksRoute.name: (routeData) {
      final args = routeData.argsAs<CollectionBooksRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.CollectionBooksPage(args.collectionId, args.collectionName,
              key: args.key));
    },
    BookInfoRoute.name: (routeData) {
      final args = routeData.argsAs<BookInfoRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.BookInfoPage(args.bookId, key: args.key));
    },
    SearchRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i9.SearchPage());
    },
    BookClubsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.BookClubsPage());
    },
    BookClubInfoRoute.name: (routeData) {
      final args = routeData.argsAs<BookClubInfoRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i11.BookClubInfoPage(args.bookId, key: args.key));
    },
    EventInfoRoute.name: (routeData) {
      final args = routeData.argsAs<EventInfoRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i12.EventInfoPage(
              key: args.key,
              eventId: args.eventId,
              clubId: args.clubId,
              isUserInClub: args.isUserInClub));
    },
    EventReviewsRoute.name: (routeData) {
      final args = routeData.argsAs<EventReviewsRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i13.EventReviewsPage(key: args.key, eventId: args.eventId));
    },
    ClubMembersRoute.name: (routeData) {
      final args = routeData.argsAs<ClubMembersRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i14.ClubMembersPage(key: args.key, clubId: args.clubId));
    },
    ProfileRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i15.ProfilePage());
    },
    UserQuotesRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i16.UserQuotesPage());
    },
    UserReviewRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i17.UserReviewPage());
    },
    UserBooksRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i18.UserBooksPage());
    },
    UserCollectionsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i19.UserCollectionsPage());
    },
    SettingsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i20.SettingsPage());
    },
    Top10Route.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i21.Top10Page());
    },
    StatisticsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i22.StatisticsPage());
    },
    AchievementsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i23.AchievementsPage());
    },
    EventsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i24.EventsPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i5.RouteConfig(SplashScreen.name, path: '/splash', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SplashScreen.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(LogInRoute.name, path: '/login', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: LogInRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(SignUpRoute.name, path: '/signup', children: [
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: SignUpRoute.name,
              redirectTo: '',
              fullMatch: true)
        ]),
        _i5.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i5.RouteConfig(CollectionsRouter.name,
              path: 'collections',
              parent: HomeRoute.name,
              children: [
                _i5.RouteConfig(CollectionsRoute.name,
                    path: '', parent: CollectionsRouter.name),
                _i5.RouteConfig(CollectionBooksRoute.name,
                    path: 'allBooks', parent: CollectionsRouter.name),
                _i5.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: CollectionsRouter.name),
                _i5.RouteConfig('*#redirect',
                    path: '*',
                    parent: CollectionsRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i5.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRoute.name,
              children: [
                _i5.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i5.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: SearchRouter.name),
                _i5.RouteConfig('*#redirect',
                    path: '*',
                    parent: SearchRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i5.RouteConfig(BookClubsRouter.name,
              path: 'bookClubs',
              parent: HomeRoute.name,
              children: [
                _i5.RouteConfig(BookClubsRoute.name,
                    path: '', parent: BookClubsRouter.name),
                _i5.RouteConfig(BookClubInfoRoute.name,
                    path: 'bookClubInfo', parent: BookClubsRouter.name),
                _i5.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: BookClubsRouter.name),
                _i5.RouteConfig(EventInfoRoute.name,
                    path: 'eventInfo', parent: BookClubsRouter.name),
                _i5.RouteConfig(EventReviewsRoute.name,
                    path: 'eventReview', parent: BookClubsRouter.name),
                _i5.RouteConfig(ClubMembersRoute.name,
                    path: 'clubMembers', parent: BookClubsRouter.name),
                _i5.RouteConfig('*#redirect',
                    path: '*',
                    parent: BookClubsRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i5.RouteConfig(ProfileRouter.name,
              path: 'profile',
              parent: HomeRoute.name,
              children: [
                _i5.RouteConfig(ProfileRoute.name,
                    path: '', parent: ProfileRouter.name),
                _i5.RouteConfig(UserQuotesRoute.name,
                    path: 'userQuotes', parent: ProfileRouter.name),
                _i5.RouteConfig(UserReviewRoute.name,
                    path: 'userReviews', parent: ProfileRouter.name),
                _i5.RouteConfig(UserBooksRoute.name,
                    path: 'userBooks', parent: ProfileRouter.name),
                _i5.RouteConfig(UserCollectionsRoute.name,
                    path: 'userCollections', parent: ProfileRouter.name),
                _i5.RouteConfig(CollectionBooksRoute.name,
                    path: 'allBooks', parent: ProfileRouter.name),
                _i5.RouteConfig(BookInfoRoute.name,
                    path: 'bookInfo', parent: ProfileRouter.name),
                _i5.RouteConfig(SettingsRoute.name,
                    path: 'settings', parent: ProfileRouter.name),
                _i5.RouteConfig(Top10Route.name,
                    path: 'top10', parent: ProfileRouter.name),
                _i5.RouteConfig(StatisticsRoute.name,
                    path: 'statistics', parent: ProfileRouter.name),
                _i5.RouteConfig(AchievementsRoute.name,
                    path: 'achievements', parent: ProfileRouter.name),
                _i5.RouteConfig(EventsRoute.name,
                    path: 'events', parent: ProfileRouter.name),
                _i5.RouteConfig('*#redirect',
                    path: '*',
                    parent: ProfileRouter.name,
                    redirectTo: '',
                    fullMatch: true)
              ]),
          _i5.RouteConfig('*#redirect',
              path: '*',
              parent: HomeRoute.name,
              redirectTo: '/home',
              fullMatch: true)
        ]),
        _i5.RouteConfig('*#redirect',
            path: '*', redirectTo: '/home', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i5.PageRouteInfo<void> {
  const SplashScreen({List<_i5.PageRouteInfo>? children})
      : super(SplashScreen.name, path: '/splash', initialChildren: children);

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.LogInPage]
class LogInRoute extends _i5.PageRouteInfo<void> {
  const LogInRoute({List<_i5.PageRouteInfo>? children})
      : super(LogInRoute.name, path: '/login', initialChildren: children);

  static const String name = 'LogInRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute({List<_i5.PageRouteInfo>? children})
      : super(SignUpRoute.name, path: '/signup', initialChildren: children);

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i5.PageRouteInfo<HomeRouteArgs> {
  HomeRoute(
      {required int userId, _i25.Key? key, List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/home',
            args: HomeRouteArgs(userId: userId, key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({required this.userId, this.key});

  final int userId;

  final _i25.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i5.EmptyRouterPage]
class CollectionsRouter extends _i5.PageRouteInfo<void> {
  const CollectionsRouter({List<_i5.PageRouteInfo>? children})
      : super(CollectionsRouter.name,
            path: 'collections', initialChildren: children);

  static const String name = 'CollectionsRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SearchRouter extends _i5.PageRouteInfo<void> {
  const SearchRouter({List<_i5.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class BookClubsRouter extends _i5.PageRouteInfo<void> {
  const BookClubsRouter({List<_i5.PageRouteInfo>? children})
      : super(BookClubsRouter.name,
            path: 'bookClubs', initialChildren: children);

  static const String name = 'BookClubsRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ProfileRouter extends _i5.PageRouteInfo<void> {
  const ProfileRouter({List<_i5.PageRouteInfo>? children})
      : super(ProfileRouter.name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i6.CollectionsPage]
class CollectionsRoute extends _i5.PageRouteInfo<void> {
  const CollectionsRoute() : super(CollectionsRoute.name, path: '');

  static const String name = 'CollectionsRoute';
}

/// generated route for
/// [_i7.CollectionBooksPage]
class CollectionBooksRoute extends _i5.PageRouteInfo<CollectionBooksRouteArgs> {
  CollectionBooksRoute(
      {required int collectionId,
      required String collectionName,
      _i25.Key? key})
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

  final _i25.Key? key;

  @override
  String toString() {
    return 'CollectionBooksRouteArgs{collectionId: $collectionId, collectionName: $collectionName, key: $key}';
  }
}

/// generated route for
/// [_i8.BookInfoPage]
class BookInfoRoute extends _i5.PageRouteInfo<BookInfoRouteArgs> {
  BookInfoRoute({required int bookId, _i25.Key? key})
      : super(BookInfoRoute.name,
            path: 'bookInfo',
            args: BookInfoRouteArgs(bookId: bookId, key: key));

  static const String name = 'BookInfoRoute';
}

class BookInfoRouteArgs {
  const BookInfoRouteArgs({required this.bookId, this.key});

  final int bookId;

  final _i25.Key? key;

  @override
  String toString() {
    return 'BookInfoRouteArgs{bookId: $bookId, key: $key}';
  }
}

/// generated route for
/// [_i9.SearchPage]
class SearchRoute extends _i5.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i10.BookClubsPage]
class BookClubsRoute extends _i5.PageRouteInfo<void> {
  const BookClubsRoute() : super(BookClubsRoute.name, path: '');

  static const String name = 'BookClubsRoute';
}

/// generated route for
/// [_i11.BookClubInfoPage]
class BookClubInfoRoute extends _i5.PageRouteInfo<BookClubInfoRouteArgs> {
  BookClubInfoRoute({required int bookId, _i25.Key? key})
      : super(BookClubInfoRoute.name,
            path: 'bookClubInfo',
            args: BookClubInfoRouteArgs(bookId: bookId, key: key));

  static const String name = 'BookClubInfoRoute';
}

class BookClubInfoRouteArgs {
  const BookClubInfoRouteArgs({required this.bookId, this.key});

  final int bookId;

  final _i25.Key? key;

  @override
  String toString() {
    return 'BookClubInfoRouteArgs{bookId: $bookId, key: $key}';
  }
}

/// generated route for
/// [_i12.EventInfoPage]
class EventInfoRoute extends _i5.PageRouteInfo<EventInfoRouteArgs> {
  EventInfoRoute(
      {_i25.Key? key,
      required int eventId,
      required int clubId,
      required bool isUserInClub})
      : super(EventInfoRoute.name,
            path: 'eventInfo',
            args: EventInfoRouteArgs(
                key: key,
                eventId: eventId,
                clubId: clubId,
                isUserInClub: isUserInClub));

  static const String name = 'EventInfoRoute';
}

class EventInfoRouteArgs {
  const EventInfoRouteArgs(
      {this.key,
      required this.eventId,
      required this.clubId,
      required this.isUserInClub});

  final _i25.Key? key;

  final int eventId;

  final int clubId;

  final bool isUserInClub;

  @override
  String toString() {
    return 'EventInfoRouteArgs{key: $key, eventId: $eventId, clubId: $clubId, isUserInClub: $isUserInClub}';
  }
}

/// generated route for
/// [_i13.EventReviewsPage]
class EventReviewsRoute extends _i5.PageRouteInfo<EventReviewsRouteArgs> {
  EventReviewsRoute({_i25.Key? key, required int eventId})
      : super(EventReviewsRoute.name,
            path: 'eventReview',
            args: EventReviewsRouteArgs(key: key, eventId: eventId));

  static const String name = 'EventReviewsRoute';
}

class EventReviewsRouteArgs {
  const EventReviewsRouteArgs({this.key, required this.eventId});

  final _i25.Key? key;

  final int eventId;

  @override
  String toString() {
    return 'EventReviewsRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [_i14.ClubMembersPage]
class ClubMembersRoute extends _i5.PageRouteInfo<ClubMembersRouteArgs> {
  ClubMembersRoute({_i25.Key? key, required int clubId})
      : super(ClubMembersRoute.name,
            path: 'clubMembers',
            args: ClubMembersRouteArgs(key: key, clubId: clubId));

  static const String name = 'ClubMembersRoute';
}

class ClubMembersRouteArgs {
  const ClubMembersRouteArgs({this.key, required this.clubId});

  final _i25.Key? key;

  final int clubId;

  @override
  String toString() {
    return 'ClubMembersRouteArgs{key: $key, clubId: $clubId}';
  }
}

/// generated route for
/// [_i15.ProfilePage]
class ProfileRoute extends _i5.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i16.UserQuotesPage]
class UserQuotesRoute extends _i5.PageRouteInfo<void> {
  const UserQuotesRoute() : super(UserQuotesRoute.name, path: 'userQuotes');

  static const String name = 'UserQuotesRoute';
}

/// generated route for
/// [_i17.UserReviewPage]
class UserReviewRoute extends _i5.PageRouteInfo<void> {
  const UserReviewRoute() : super(UserReviewRoute.name, path: 'userReviews');

  static const String name = 'UserReviewRoute';
}

/// generated route for
/// [_i18.UserBooksPage]
class UserBooksRoute extends _i5.PageRouteInfo<void> {
  const UserBooksRoute() : super(UserBooksRoute.name, path: 'userBooks');

  static const String name = 'UserBooksRoute';
}

/// generated route for
/// [_i19.UserCollectionsPage]
class UserCollectionsRoute extends _i5.PageRouteInfo<void> {
  const UserCollectionsRoute()
      : super(UserCollectionsRoute.name, path: 'userCollections');

  static const String name = 'UserCollectionsRoute';
}

/// generated route for
/// [_i20.SettingsPage]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i21.Top10Page]
class Top10Route extends _i5.PageRouteInfo<void> {
  const Top10Route() : super(Top10Route.name, path: 'top10');

  static const String name = 'Top10Route';
}

/// generated route for
/// [_i22.StatisticsPage]
class StatisticsRoute extends _i5.PageRouteInfo<void> {
  const StatisticsRoute() : super(StatisticsRoute.name, path: 'statistics');

  static const String name = 'StatisticsRoute';
}

/// generated route for
/// [_i23.AchievementsPage]
class AchievementsRoute extends _i5.PageRouteInfo<void> {
  const AchievementsRoute()
      : super(AchievementsRoute.name, path: 'achievements');

  static const String name = 'AchievementsRoute';
}

/// generated route for
/// [_i24.EventsPage]
class EventsRoute extends _i5.PageRouteInfo<void> {
  const EventsRoute() : super(EventsRoute.name, path: 'events');

  static const String name = 'EventsRoute';
}
