import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/widget/custom_appbar.dart';
import 'package:khuthon_2024/main.dart';
import "package:http/http.dart" as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class AnimalManypage extends StatefulWidget {
  static const routeName = "/animalmanypage";


  AnimalManypage({Key? key}) : super(key: key);

  @override
  _AnimalManypageState createState() => _AnimalManypageState();
}

class _AnimalManypageState extends State<AnimalManypage> {
  var value;
  final String animalTitle = "멸종위기동물 도감";

  // 예시 데이터: 동물 정보
  List<Animal> animals = [
    Animal(name: "no.001 고양이", image: "assets/animals/cat.gif"),
    Animal(name: "no.002 홍학", image: "assets/animals/redbird.gif"),
    Animal(name: "no.003 돼지", image: "assets/animals/pig.png"),
    Animal(name: "no.004 렛서판다", image: "assets/animals/redpanda.png"),
    Animal(name: "no.005 연못거북", image: "assets/animals/turtle.png"),
    Animal(name: "no.006 수달", image: "assets/animals/soodal.gif"),
    Animal(name: "no.007 큰부리새", image: "assets/animals/parrot.png"),
    Animal(name: "no.008 코알라", image: "assets/animals/koala.png"),
    Animal(name: "no.009 듀공", image: "assets/animals/dolpin.png"),
    Animal(name:"no.010 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.011 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.012 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.013 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.014 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.015 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.016 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.017 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.018 ????", image:"assets/animals/question.gif"),

    // 여기에 나머지 동물들 추가
  ];

  // 선택된 동물 정보
  late Animal? selectedAnimal;

  @override
  void initState() {
    super.initState();
    // 페이지에 들어올 때 첫 번째 동물을 선택
    selectedAnimal = animals.isNotEmpty ? animals.first : null;
    _fetchData();
  }

  Future<void> _fetchData() async {
    String url = 'http://172.21.119.167:8000/mileleage';
    print(url);
    var response = await http.get(Uri.parse(url));
    var decodedData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> data = jsonDecode(decodedData);

    print(data);
    value = data['value'];
    print(value.toString());
    print('Received value: $value');

    if (response.statusCode == 200) {
      print('Recommendations sent successfully!');
    } else {
      print(
          'Failed to send recommendations. Error code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "도감",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xff294638),
          ),
        ),
        backgroundColor: Color(0xffebeedd),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff284738),
        ),
      ),
      backgroundColor: Color(0xffebeedd),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child:  LinearPercentIndicator(
                  width: 320.0,
                  lineHeight: 19.0,
                  percent: 0.45,
                  center: Text(
                    "3757",
                    style: TextStyle(fontSize: 14.0,
                    fontWeight: FontWeight.w800),
                  ),
                  trailing: Text("70,000원", style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                ),
              ),
              // CustomAppBar(appBartitle: animalAppbarTitle, route: MyHomePage.routeName),
              SizedBox(height: 20),
              // 선택된 동물 이름과 사진 표시
              selectedAnimal != null
                  ? Column(
                children: [
                  Text(
                    selectedAnimal!.name,
                    style: TextStyle(fontSize: 24,
                        color:Color(0xff82D072),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset(selectedAnimal!.image, width: 200, height: 200),
                ],
              )
                  : Container(), // 선택된 동물이 없을 때는 아무것도 표시하지 않음
              SizedBox(height: 20),
              // 동물 도감
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                ),
                itemCount: animals.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnimal = animals[index];
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          animals[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 5),
                        Text(
                          animals[index].name,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 동물 정보 모델
class Animal {
  final String name;
  final String image;

  Animal({required this.name, required this.image});
}
