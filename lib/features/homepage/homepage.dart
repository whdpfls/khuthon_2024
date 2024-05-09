
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khuthon_2024/features/guidepage/guidepage.dart';
import 'package:khuthon_2024/features/widget/custom_appbar.dart';
import 'package:khuthon_2024/main.dart';

class Homepage extends StatelessWidget {
  static const routeName = "/homepage";
  final String homeAppbarTitle = "홈입니다.";

  const Homepage({
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
            CustomAppBar(appBartitle: homeAppbarTitle, route: Guidepage.routeName),
          ],
        ),
      ),
    );
  }
}
