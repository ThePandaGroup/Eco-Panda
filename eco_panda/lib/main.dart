import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './ehomepage.dart';
import './echallenges.dart';
import './efriends.dart';
import './eleaderboards.dart';
import './emap_nav.dart';
import './eprofile.dart';
import './esettings.dart';
import './ecarbon_history.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const EPandaHomepage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'carbon-history',
          builder: (BuildContext context, GoRouterState state) {
            return const ECarbonHistory();
          },
        ),
        GoRoute(
          path: 'route-planning',
          builder: (BuildContext context, GoRouterState state) {
            return const EMapNav();
          },
        ),
        GoRoute(
          path: 'friends',
          builder: (BuildContext context, GoRouterState state) {
            return const EFriends();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/challenges',
      builder: (BuildContext context, GoRouterState state) {
        return const EChallenges();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'leaderboard',
          builder: (BuildContext context, GoRouterState state) {
            return const ELeaderboards();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const EProfile();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const ESettings();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

// '/': (context) => const EPandaHomepage(), // Homepage - index 0
// '/route-planning': (context) => const EMapNav(), // Route Planning Page
// '/profile': (context) => const EProfile(), // Profile Page - index 2
// '/friends': (context) => const EFriends(), // Friends Page -
// '/settings': (context) => const ESettings(), // Settings Page -
// '/challenges': (context) => const EChallenges(), // Challenges Page - index 1
// '/leaderboards': (context) => const ELeaderboards(), // Leaderboards Page -
// '/carbon-history': (context) => const ECarbonHistory(), // Carbon Footprint History -