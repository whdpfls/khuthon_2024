import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khuthon_2024/features/homepage/homepage.dart';
import 'package:khuthon_2024/features/homepage/point_check.dart';
import 'package:khuthon_2024/main.dart';



final router = GoRouter(
  initialLocation: MyHomePage.routeName,
  routes: [
    GoRoute(path: MyHomePage.routeName, builder: (context,state){
      return MyHomePage();
    },
    ),
    GoRoute(path: '/homepage', builder: (context,state){
      return Homepage();
    },
    ),
    GoRoute(path: Pointcheck.routename, builder: (context,state){
      return Pointcheck();
    },
    ),
  ],
);