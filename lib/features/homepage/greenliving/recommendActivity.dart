import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecomActivity extends StatelessWidget {
  static const routename = '/recomactivity';
  List<Map<String,dynamic>> responseList = [];

  RecomActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "오늘의 녹색활동 추천",
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
      body: recommenditemView(),

    );
  }
}

class recommenditemView extends StatefulWidget {
  const recommenditemView({super.key});

  @override
  State<recommenditemView> createState() => _recommenditemViewState();
}

class _recommenditemViewState extends State<recommenditemView> {
  List<String> itemList = [
    "집에서 하기",
    "나가서 친구와 함께하기",
    "나가서 혼자하기",
    "날씨와 상관 없는 일",
    "날씨 좋은날 할 수 있는 일"
  ];
  List<bool> _isCheckedList = List.generate(
      5, (index) => false); // 체크 여부를 저장할 리스트

  String generateRecommendation() {
    List<String> selectedItems = [];
    for (int i = 0; i < itemList.length; i++) {
      if (_isCheckedList[i]) {
        selectedItems.add(itemList[i]);
      }
    }

    // 선택된 항목들에 따라 추천할 환경보호 활동을 정의합니다.
    String recommendations = "";
    if (selectedItems.contains("집에서 하기")) {
      recommendations += "집에서 하기,";
    }
    if (selectedItems.contains("나가서 친구와 함께하기")) {
      recommendations += "나가서 친구와 함께하기,";
    }
    if (selectedItems.contains("나가서 혼자하기")) {
      recommendations += "나가서 혼자하기,";
    }
    if (selectedItems.contains("날씨와 상관 없는 일")) {
      recommendations += "날씨와 상관 없는 일,";
    }
    if (selectedItems.contains("날씨 좋은날 할 수 있는 일")) {
      recommendations += "날씨 좋은 날 할 수 있는 일,";
    }


    return recommendations;
  }


  Future<void> sendRecommendations(String recommendations) async {
    String url = 'http://172.21.119.167:8000/envactivity';
    // print(recommendations.runtimeType);


    String requestData = jsonEncode({ 'type':'string','value': recommendations});
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestData);


    var decodedData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> data = jsonDecode(decodedData);
    List<String> valueList = data['value'].cast<String>();
    print(valueList[0]);


    if (response.statusCode == 200) {
      print('Recommendations sent successfully!');
    } else {
      print(
          'Failed to send recommendations. Error code: ${response.statusCode}');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF284738)))),
            child: Text("마음에 드는 활동유형을 골라주세요.", style: TextStyle(
              color: Color(0xff284738),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),),
          ),
          SizedBox(height: 20,),
          Column(
            children: [
              for(int i = 0; i < itemList.length; i++)
                CheckboxListTile(
                  title: Text(itemList[i]),
                  value: _isCheckedList[i],
                  onChanged: (newValue) {
                    setState(() {
                      _isCheckedList[i] = newValue!;
                    });
                  },
                ),
            ],
          ),
          SizedBox(height: 300),
          SizedBox(
            width: 330,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                String recommendations = generateRecommendation();
                print(recommendations);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("환경 보호 활동 추천"),
                      content: Text(recommendations.isNotEmpty
                          ? recommendations
                          : "선택된 활동이 없습니다."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            sendRecommendations(recommendations);
                            // getguideline();
                          },
                          child: Text("추천"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                '추천받기',
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
        ],
      ),
    );
  }
}
