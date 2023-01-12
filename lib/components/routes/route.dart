import 'package:auto_route/auto_route.dart';
import 'package:shelfie/screens/collections/collection_page.dart';
import 'package:shelfie/screens/home/home_page.dart';
import 'package:shelfie/screens/log_in/log_in_page.dart';
import 'package:shelfie/screens/search/search_page.dart';
import 'package:shelfie/screens/sign_up/sign_up_page.dart';

import '../../screens/filter/filter_page.dart';
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
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'profile',
          name: 'ProfileRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfilePage),
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