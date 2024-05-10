import 'package:flutter/material.dart';
import 'package:khuthon_2024/app_router.dart';
import 'package:khuthon_2024/features/Animal/animalpage.dart';
import 'package:khuthon_2024/features/guidepage/guidepage.dart';
import 'package:khuthon_2024/features/homepage/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Homepage',
      theme: ThemeData(
        fontFamily: 'NanumSquareRound',
      ),
      themeMode: ThemeMode.system,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName='/apphomepage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String appBarTitle = '가이드'; // 초기값은 가이드 페이지로 설정

  static List<Widget> _widgetOptions = <Widget>[
    Guidepage(),
    Homepage(),
    Animalpage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index) {
        case 0:
          appBarTitle = '가이드';
          break;
        case 1:
          appBarTitle = '홈';
          break;
        case 2:
          appBarTitle = '도감';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xff294638),
          ),
        ),
        backgroundColor: Color(0xffebeedd),
      ),
      body: Container(
        color: Color(0xffebeedd),
        child: GestureDetector(
          onTap: () {
            setState(() {
              switch (_selectedIndex) {
                case 0:
                  Navigator.pushNamed(context, Guidepage.routeName);
                  break;
                case 1:
                  Navigator.pushNamed(context, Homepage.routeName);
                  break;
                case 2:
                  Navigator.pushNamed(context, Animalpage.routeName);
                  break;
              }
            });
          },
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffebeedd),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '가이드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.attach_money_outlined),
          //   label: '포인트',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: '도감',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff297326),
        selectedLabelStyle: TextStyle(
          color: Color(0xff297326),
          fontWeight: FontWeight.w900,
        ),
        unselectedItemColor: Color(0xff4e4f4b),
        unselectedLabelStyle: TextStyle(
          color: Color(0xff4e4f4b),
          fontWeight: FontWeight.w900,
        ),
        onTap: _onItemTapped,
      ),
    );
  }
}
