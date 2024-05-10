import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Guidepage extends StatelessWidget {
  static const routeName = "/guidepage";
  final String guideAppbarTitle = "탄소중립에너지 녹색생활 실천";
  List<Map<String, dynamic>> responseList = [];

  Guidepage({
    super.key,
  });

  Future<void> getguideline() async {
    String url = 'http://172.21.119.167:8000/guideline';
    print(url);
    var response = await http.get(Uri.parse(url));
    var decodedData = utf8.decode(response.bodyBytes);
    Map<String, dynamic> data = jsonDecode(decodedData);
    List<Map<String, dynamic>> valueList =
        List<Map<String, dynamic>>.from(data['value']);
    responseList = valueList;

    if (response.statusCode == 200) {
      print('Recommendations sent successfully!');
    } else {
      print(
          'Failed to send recommendations. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    getguideline();
    // responseList.forEach((element) {
    //   var id = element['properties']['id'];
    //   var title = element['properties']['title'];
    //   var content = element['properties']['content'];
    //
    // });
    // print(responseList.length);

    return SafeArea(
      left: false,
      right: false,
      top: true,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SearchBar(
                  leading: Icon(Icons.search),
                  hintText: "검색어를 입력하세요",
                  trailing: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_voice),
                      onPressed: () {
                        print('Use voice command');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: () {
                        print('Use image search');
                      },
                    ),
                  ],
                  shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                ),
              ),
              SizedBox(height: 20),
              for (var item in responseList)...[
                if(item['properties']['id']==6)
                  GuideItem(
                    id: item['properties']['id'],
                    title: item['properties']['title'],
                    content: item['properties']['content'],
                    outurl: 'https://cpoint.or.kr/netzero/main.do'
                  ),
                if(item['properties']['id']==15)
                  GuideItem(
                    id: item['properties']['id'],
                    title: item['properties']['title'],
                    content: item['properties']['content'],
                    outurl: 'https://ecomileage.seoul.go.kr/home'
                  ),
                if(item['properties']['id'] != 6 && item['properties']['id'] !=15)
                  GuideItem(
                  id: item['properties']['id'],
                  title: item['properties']['title'],
                  content: item['properties']['content'],
                ),
                SizedBox(height: 20)
              ]

            ],
          ),
        ),
      ),
    );
  }
}

class GuideItem extends StatelessWidget {
  int id;
  String title;
  String content;
  String? outurl;

  GuideItem(
      {super.key,
      required this.id,
      required this.title,
      required this.content,
        this.outurl,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffc9d8b7),
          borderRadius:BorderRadius.circular(30) ),
      width: 360,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(id.toString()+'.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(content,
              textScaler: TextScaler.noScaling,
              style:TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              ),
              if (outurl != null)
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () async {
                    final url = Uri.parse(outurl!);
                    if (await canLaunchUrl(url)) {
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                ),

            ],
          ),
        ),
      ),
    );
  }
}
