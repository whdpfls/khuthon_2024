
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khuthon_2024/features/homepage/homepage.dart';
import 'package:khuthon_2024/features/widget/custom_appbar.dart';
import 'package:khuthon_2024/main.dart';

class Guidepage extends StatelessWidget {
  static const routeName = "/guidepage";
  final String guideAppbarTitle = "탄소중립에너지 녹색생활 실천";

  const Guidepage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top:true,
      child: Center(
        child: Column(
          children: [
            CustomAppBar(appBartitle: guideAppbarTitle, route: Homepage.routeName),
          ],
        ),
      ),
    );
  }
}
