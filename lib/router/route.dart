import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ui/pages/home_page.dart';

class Routes {
  static const mainRoute = '/';
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.mainRoute,
      builder: (_, __) => const HomePage()
    )
  ],
);

GoRouter get router => _router;
