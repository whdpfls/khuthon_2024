import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/Animal/animalManyver.dart';
import 'package:khuthon_2024/features/homepage/convertpoint.dart';

class Pointcheck extends StatelessWidget {
  static const routename = '/pointcheck';

  const Pointcheck({super.key});

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
      body: _PointView(),

    );
  }
}


class _PointView extends StatefulWidget {

  const _PointView({super.key});

  @override
  State<_PointView> createState() => _PointViewState();
}

class _PointViewState extends State<_PointView> {
  bool _isLoading = false;
  bool _showContent = false;
  TextEditingController _controller = TextEditingController();
  bool showIndicator = false;

  void showMileageContainer() {
    // 2초 후에 상태를 업데이트하고 인디케이터를 숨기고 텍스트 컨테이너를 보여줍니다.
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showIndicator = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 50,
              child: Center(
                child: Text("마일리지 8750p 획득"),
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '주거환경정보',
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
            SizedBox(height: 20,),
            EnvInfoRow(),
            SizedBox(height: 15,),
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '거주면적',
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
            SizedBox(height: 20,),
            HomeInfoRow(),
            SizedBox(height: 15,),
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '거주인원',
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
            SizedBox(height: 20,),
            PersonInfoRow(),
            SizedBox(height: 15,),
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  // 3초 후에 _isLoading을 false로 설정하여 진행 표시기를 숨깁니다.
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      _isLoading = false;
                      _showContent = true;
                    });
                  });
                },
                child: Text(
                  '전기/상수도/도시가스 사용량 입력',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("2024년도 3월 ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color:Color(0xff284738)),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "전기",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width:60,),
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "수도",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 60,),
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "가스",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Text("2024년도 4월 ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color:Color(0xff284738)),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "전기",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width:60,),
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "수도",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 60,),
                  Container(
                    width: 80,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "가스",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    showMileageContainer();
                  },
                  onLongPress:(){ Navigator.push(context,MaterialPageRoute(builder: (context)=> AnimalManypage()),);},
                  child: Text(
                    '예상 탄소중립실천포인트 보기',
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
      ),
    );
  }
}





class CheckBoxUnit extends StatefulWidget {
  String type;
  CheckBoxUnit({super.key, required this.type});

  @override
  State<CheckBoxUnit> createState() => _CheckBoxUnitState();
}

class _CheckBoxUnitState extends State<CheckBoxUnit> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        Text(widget.type),
        SizedBox(width: 10,),

      ],
    );
  }
}


class PersonInfoRow extends StatefulWidget {
  const PersonInfoRow({super.key});

  @override
  State<PersonInfoRow> createState() => _PersonInfoRowState();
}

class _PersonInfoRowState extends State<PersonInfoRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CheckBoxUnit(type:"1명"),
            CheckBoxUnit(type:"2명~3명"),
            CheckBoxUnit(type:"4명~5명"),
            CheckBoxUnit(type:"6명 이상"),
          ],
        ),
      ),
    );
  }
}







class HomeInfoRow extends StatefulWidget {
  const HomeInfoRow({Key? key}) : super(key: key);

  @override
  _HomeInfoRowState createState() => _HomeInfoRowState();
}

class _HomeInfoRowState extends State<HomeInfoRow> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CheckBoxUnit(type:"10평 미만"),
            CheckBoxUnit(type:"10평 ~ 20평"),
            CheckBoxUnit(type:"20평 ~ 30평"),
            CheckBoxUnit(type:"30평 ~ 40평"),
            CheckBoxUnit(type:"40평 초과"),
          ],
        ),
      ),
    );
  }
}


class EnvInfoRow extends StatefulWidget {
  const EnvInfoRow({Key? key}) : super(key: key);

  @override
  _EnvInfoRowState createState() => _EnvInfoRowState();
}

class _EnvInfoRowState extends State<EnvInfoRow> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CheckBoxUnit(type:"아파트"),
            CheckBoxUnit(type:"단독주택"),
            CheckBoxUnit(type:"연립/다세대/다가구"),
            CheckBoxUnit(type:"기타"),
          ],
        ),
      ),
    );
  }
}