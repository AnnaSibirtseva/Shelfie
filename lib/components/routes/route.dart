import 'package:auto_route/auto_route.dart';
import 'package:shelfie/screens/collections/collection_page.dart';
import 'package:shelfie/screens/home/home_page.dart';
import 'package:shelfie/screens/log_in/log_in_page.dart';
import 'package:shelfie/screens/search/search_page.dart';
import 'package:shelfie/screens/sign_up/sign_up_page.dart';

import '../../screens/book/book_info/book_info_page.dart';
import '../../screens/collections/books/books_page.dart';
import '../../screens/filter/filter_page.dart';
import '../../screens/profile/extra/settings/settings_page.dart';
import '../../screens/profile/interactions/books/user_books_page.dart';
import '../../screens/profile/interactions/collections/user_collections_page.dart';
import '../../screens/profile/interactions/quotes/user_quotes_page.dart';
import '../../screens/profile/interactions/reviews/user_review_page.dart';
import '../../screens/profile/profile_page.dart';


@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
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
            AutoRoute(path: 'filters', page: FilterPage),
            AutoRoute(path: 'bookInfo', page: BookInfoPage),
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
            AutoRoute(path: 'settings', page: SettingsPage),
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