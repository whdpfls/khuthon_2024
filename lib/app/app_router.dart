import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khuthon_2024/features/guidepage/guidepage.dart';
import 'package:khuthon_2024/features/homepage/homepage.dart';
import 'package:khuthon_2024/main.dart';

class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;
  static final _router = GoRouter(
    initialLocation: MyHomePage.routeName,
    routes: [
      GoRoute(
        path: MyHomePage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return MyHomePage();
        },
      ),
      GoRoute(
        path: Guidepage.routeName,
        builder: (BuildContext context, GoRouterState state) {
          return Guidepage();
        },
      ),
      GoRoute(
          path: Homepage.routeName,
          builder: (BuildContext context, GoRouterState state) {
            return Homepage();
          })
    ],
  );
}
