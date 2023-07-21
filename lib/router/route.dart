import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/list_device/list_device_page.dart';

class Routes {
  static const mainRoute = '/';
  static const devices = '/devices';
}

final _router = GoRouter(
  initialLocation: Routes.mainRoute,
  routes: [
    GoRoute(
      path: Routes.mainRoute,
      builder: (_, __) => const HomePage()
    ),
    GoRoute(
        path: Routes.mainRoute,
        builder: (_, __) => const ListDevicePage()
    ),
  ],
);

GoRouter get router => _router;
