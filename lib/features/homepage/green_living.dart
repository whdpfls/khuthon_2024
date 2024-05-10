import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/homepage/greenliving/flogging.dart';
import 'package:khuthon_2024/features/homepage/greenliving/recommendActivity.dart';

class Greenliving extends StatelessWidget {
  static const routename = '/greenliving';

  const Greenliving({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "녹색생활실천활동",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xff284738),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff284738),
        ),
        backgroundColor: Color(0xffebeedd),
      ),
      backgroundColor: Color(0xffebeedd),
      body: greenlivinglistView(),

    );
  }
}

class greenlivinglistView extends StatelessWidget {
  const greenlivinglistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            width: 330,
            height: 80,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> RecomActivity()),);
              },
              child: Text(
                '오늘의 녹색활동 추천',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffebeedd),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 330,
            height: 80,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Flogging()),);
              },
              child: Text(
                '플로깅',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffebeedd),
              ),
            ),
          ),
          SizedBox(height: 20,),

        ],
      )
    );
  }
}
