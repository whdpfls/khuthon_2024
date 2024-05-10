


import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile? selectedImage1;
  XFile? selectedImage2;
  final ImagePicker _imagePicker = ImagePicker();
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
                child: Text("포인트 3757p 획득"),
              ),
            ),
          );
        },
      );
    });
  }


  Future<void> uploadImage(XFile image) async {
    if (image != null) {
      final url = 'http://172.21.119.167:8000/mileleage/flogging'; // 이미지를 업로드할 서버 URL

      try {
        final bytes = await image.readAsBytes(); // 이미지를 바이트 배열로 읽어옴


        var response = await http.post(
          Uri.parse(url),
          body: bytes,
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          // 성공적으로 서버에 이미지를 업로드한 경우
          print('이미지 업로드 성공');
        } else {
          // 서버에 이미지를 업로드하지 못한 경우
          print('이미지 업로드 실패');
        }
      } catch (e) {
        print('이미지 업로드 오류: $e');
      }
    } else {
      print('이미지를 선택해주세요.');
    }
  }// ImagePicker 객체 생성



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            width: 360,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF284738))),
            ),
            child: Text(
              "플로깅 하시기 전과 후 사진을 업로드하시면 마일리지 점수로 환산해드립니다.",
              style: TextStyle(
                color: Color(0xff284738),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 100),
          if (selectedImage1 != null)
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(selectedImage1!.path)),
            ),
          TextButton(
            onPressed: () async {
              final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  selectedImage1 = image;
                  uploadImage(selectedImage1!);
                });
              } else {
                print('아무것도 선택하지 않았습니다.');
              }
            },
            child: const Text('활동 전 사진'),
          ),
          SizedBox(height: 30),
          if (selectedImage2 != null)
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(File(selectedImage2!.path)),
                ),
                if (showIndicator)
                  CircularProgressIndicator(),
              ],
            ),
          TextButton(
            onPressed: () async {
              final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  selectedImage2 = image;
                  showIndicator = true;
                  uploadImage(selectedImage2!);
                  // 이미지 선택 후 인디케이터를 보여줍니다.
                  showMileageContainer();
                });
              } else {
                print('아무것도 선택하지 않았습니다.');
              }
            },
            child: const Text('활동 후 사진'),
          ),
        ],
      ),
    );
  }
}