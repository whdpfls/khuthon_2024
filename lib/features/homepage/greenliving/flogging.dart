import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/homepage/convertpoint.dart';

class Flogging extends StatelessWidget {
  static const routename = '/flogging';

  const Flogging({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "플로깅 실천하기",
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
      body: FloggingContent(),

    );
  }
}

class FloggingContent extends StatefulWidget {
  const FloggingContent({super.key});

  @override
  State<FloggingContent> createState() => _FloggingContentState();
}

class _FloggingContentState extends State<FloggingContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color:Color(0xFF284738)))),
            child: Text("오늘 하고 싶은 일을 골라주세요.", style: TextStyle(
              color:Color(0xff284738),
              fontSize:14,
              fontWeight: FontWeight.w800,
            ))
          )
        ],
      )
    );
  }
}


