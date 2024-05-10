import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/widget/custom_appbar.dart';
import 'package:khuthon_2024/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Animalpage extends StatefulWidget {
  static const routeName = "/animalpage";

  const Animalpage({Key? key}) : super(key: key);

  @override
  _AnimalpageState createState() => _AnimalpageState();
}

class _AnimalpageState extends State<Animalpage> {
  final String animalTitle = "멸종위기동물 도감";

  // 예시 데이터: 동물 정보
  List<Animal> animals = [
    Animal(name:"no.001 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.002 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.003 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.004 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.005 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.006 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.007 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.008 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.009 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.010 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.011 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.012 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.013 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.014 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.015 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.016 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.017 ????", image:"assets/animals/question.gif"),
    Animal(name:"no.018 ????", image:"assets/animals/question.gif"),

    // Animal(name: "no.001 고양이", image: "assets/animals/cat.gif"),
    // Animal(name: "no.002 홍학", image: "assets/animals/redbird.gif"),
    // Animal(name: "no.003 돼지", image: "assets/animals/pig.png"),
    // Animal(name: "no.004 렛서판다", image: "assets/animals/redpanda.png"),
    // Animal(name: "no.005 연못거북", image: "assets/animals/turtle.png"),
    // Animal(name: "no.006 수달", image: "assets/animals/soodal.gif"),
    // Animal(name: "no.007 큰부리새", image: "assets/animals/parrot.png"),
    // Animal(name: "no.008 코알라", image: "assets/animals/koala.png"),
    // Animal(name: "no.009 듀공", image: "assets/animals/dolpin.png"),
    // Animal(name: "no.005 연못거북", image: "assets/animals/turtle.png"),
    // Animal(name: "no.006 수달", image: "assets/animals/soodal.gif"),
    // Animal(name: "no.007 큰부리새", image: "assets/animals/parrot.png"),
    // Animal(name: "no.008 코알라", image: "assets/animals/koala.png"),
    // Animal(name: "no.009 듀공", image: "assets/animals/dolpin.png"),
    // 여기에 나머지 동물들 추가
  ];

  // 선택된 동물 정보
  late Animal? selectedAnimal;

  @override
  void initState() {
    super.initState();
    // 페이지에 들어올 때 첫 번째 동물을 선택
    selectedAnimal = animals.isNotEmpty ? animals.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child:  LinearPercentIndicator(
                width: 320.0,
                lineHeight: 14.0,
                percent: 0.0,
                center: Text(
                  "0.0%",
                  style: TextStyle(fontSize: 12.0),
                ),
                trailing: Text("70,000원", style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
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
    );
  }
}

// 동물 정보 모델
class Animal {
  final String name;
  final String image;

  Animal({required this.name, required this.image});
}
