import 'package:auto_route/auto_route.dart';

import '../../screens/book/book_info/book_info_page.dart';
import '../../screens/book_club/book_club_info/book_club_info_page.dart';
import '../../screens/book_club/book_clubs_page.dart';
import '../../screens/book_club/event_info/event_info_page.dart';
import '../../screens/book_club/members/members_page.dart';
import '../../screens/book_club/reviews/event_reviews_page.dart';
import '../../screens/collections/books/books_page.dart';
import '../../screens/collections/collection_page.dart';
import '../../screens/home/home_page.dart';
import '../../screens/log_in/log_in_page.dart';
import '../../screens/profile/components/top_10/top_10_page.dart';
import '../../screens/profile/extra/settings/settings_page.dart';
import '../../screens/profile/interactions/achievements/achievements_page.dart';
import '../../screens/profile/interactions/books/user_books_page.dart';
import '../../screens/profile/interactions/collections/user_collections_page.dart';
import '../../screens/profile/interactions/events/events_page.dart';
import '../../screens/profile/interactions/quotes/user_quotes_page.dart';
import '../../screens/profile/interactions/reviews/user_review_page.dart';
import '../../screens/profile/interactions/statistics/statistics_page.dart';
import '../../screens/profile/profile_page.dart';
import '../../screens/search/search_page.dart';
import '../../screens/sign_up/sign_up_page.dart';
import '../../screens/splash/splash_screen.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/splash',
      page: SplashScreen,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/login',
      page: LogInPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute(
      path: '/signup',
      page: SignUpPage,
      children: [
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),

    //user routes with a nested router
    AutoRoute(
      path: '/home',
      page: HomePage,
      children: [
        AutoRoute(
          path: 'collections',
          name: 'CollectionsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: CollectionsPage),
            //AutoRoute(path: 'books', page: CollectionBooksPage),
            AutoRoute(path: 'allBooks', page: CollectionBooksPage),
            AutoRoute(path: 'bookInfo', page: BookInfoPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'search',
          name: 'SearchRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SearchPage),
            AutoRoute(path: 'bookInfo', page: BookInfoPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'bookClubs',
          name: 'BookClubsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: BookClubsPage),
            AutoRoute(path: 'bookClubInfo', page: BookClubInfoPage),
            AutoRoute(path: 'bookInfo', page: BookInfoPage),
            AutoRoute(path: 'eventInfo', page: EventInfoPage),
            AutoRoute(path: 'eventReview', page: EventReviewsPage),
            AutoRoute(path: 'clubMembers', page: ClubMembersPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'profile',
          name: 'ProfileRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfilePage),
            AutoRoute(path: 'userQuotes', page: UserQuotesPage),
            AutoRoute(path: 'userReviews', page: UserReviewPage),
            AutoRoute(path: 'userBooks', page: UserBooksPage),
            AutoRoute(path: 'userCollections', page: UserCollectionsPage),
            AutoRoute(path: 'allBooks', page: CollectionBooksPage),
            AutoRoute(path: 'bookInfo', page: BookInfoPage),
            AutoRoute(path: 'settings', page: SettingsPage),
            AutoRoute(path: 'top10', page: Top10Page),
            AutoRoute(path: 'statistics', page: StatisticsPage),
            AutoRoute(path: 'achievements', page: AchievementsPage),
            AutoRoute(path: 'events', page: EventsPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        // redirect all other paths
        RedirectRoute(path: '*', redirectTo: '/home'),
      ],
    ),
    // redirect all other paths
    RedirectRoute(path: '*', redirectTo: '/home'),
  ],
)
class $AppRouter {}
