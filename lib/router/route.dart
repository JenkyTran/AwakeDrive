import 'package:go_router/go_router.dart';

import '../ui/pages/about/about_page.dart';
import '../ui/pages/begin/begin_page.dart';
import '../ui/pages/devices/devices_page.dart';
import '../ui/pages/history/history_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/music_player/music_player_page.dart';

class Routes {
  static const begin = '/begin';
  static const devices = '/devices';
  static const main = '/';
  static const home = 'home';
  static const musicPlayer = 'music-player';
  static const history = 'history';
  static const about = 'about';
}

final _router = GoRouter(
  initialLocation: Routes.devices,
  routes: [
    GoRoute(path: Routes.begin, builder: (_, __) => const BeginPage()),
    GoRoute(path: Routes.devices, builder: (_, __) => const DevicesPage()),
    GoRoute(
      path: Routes.main,
      redirect: (_, __) => Routes.home,
      routes: [
        GoRoute(path: Routes.home, builder: (_, __) => const HomePage()),
        GoRoute(path: Routes.musicPlayer, builder: (_, __) => const MusicPlayerPage()),
        GoRoute(path: Routes.history, builder: (_, __) => const HistoryPage()),
        GoRoute(path: Routes.about, builder: (_, __) => const AboutPage()),
      ],
    ),
  ],
);

GoRouter get router => _router;
