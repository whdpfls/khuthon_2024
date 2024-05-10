import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khuthon_2024/features/homepage/point_check.dart';

class Homepage extends StatelessWidget {
  static const routeName = "/homepage";
  final String homeAppbarTitle = "포인트 쌓기 활동";

  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: true,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 230),
            SizedBox(
              width: 330,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Pointcheck()),);
                },
                child: Text(
                  '내 탄소중립포인트 확인',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                },
                child: Text(
                  '녹색생활실천활동',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
