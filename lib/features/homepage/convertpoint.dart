import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/Animal/animalManyver.dart';
import 'package:khuthon_2024/features/Animal/animalpage.dart';

class Convertpoint extends StatelessWidget {
  static const routename = '/convertpoint';

  const Convertpoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "탄소중립포인트 확인하기",
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

      body: SizedBox(
        width: 330,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=> AnimalManypage()),);
          },
          child: Text(
            '마일리지 도감확인',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ),


    );
  }
}

