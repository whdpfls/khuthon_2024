import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height:30),
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
          SizedBox(height: 40,),
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
          SizedBox(height: 40,),
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
          SizedBox(height: 40,),
          Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 330,
                  height: 100,
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
                      '전기/상수도/도시가스\n사용량 불러오기',
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
                if (_isLoading)
                  CircularProgressIndicator(), // _isLoading이 true이면 진행 표시기를 표시합니다.
              ],
            ),
          SizedBox(height: 40,),
          if(_showContent)
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Convertpoint()),);
                },
                child: Text(
                  '예상 탄소중립실천포인트 확인',
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