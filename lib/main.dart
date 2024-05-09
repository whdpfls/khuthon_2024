import 'package:flutter/material.dart';
import 'package:khuthon_2024/features/guidepage/guidepage.dart';
import 'package:khuthon_2024/features/homepage/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Homepage',
      theme: ThemeData(
        fontFamily: 'NanumSquareRoundB',
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName='/homepage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const Guidepage(),
    Text('검색페이지'),
    const Homepage(),
    Text('마일리지페이지'),
    Text('도감페이지'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Flutter Homepage',
      //     style: TextStyle(
      //       fontFamily: 'NanumSquareRoundB',
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //       color: Color(0xff294638),
      //     ),
      //   ),
      //   backgroundColor: Color(0xffebeedd),
      // ),
      body: Container(
        color: Color(0xffebeedd),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffebeedd),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '가이드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: '마일리지',
          ),
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
