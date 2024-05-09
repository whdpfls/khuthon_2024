
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_router.dart';

class CustomAppBar extends StatelessWidget {
  final String appBartitle;
  final String route;

  const CustomAppBar({super.key, required this.appBartitle, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 410,
      height: 70,
      // color: Colors.blue,
      color:Color(0xffebeedd),
      child: Row(
        children: [
          InkWell(
            child: SizedBox(
              width:30,
              height: 30,
              // child: Image.asset('assets/icons/arrow-left-linear.png', fit:BoxFit.cover),
              child: Icon(Icons.arrow_back_ios),
            ),
            onTap: (){
              AppRouter.router.go(route);
            },
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            appBartitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xff284738),
            ),
          ),
        ],
      ),
    );
  }
}
