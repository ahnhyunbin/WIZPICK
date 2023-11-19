import 'package:cdsf/screen/chatbot_screen.dart';
import 'package:cdsf/screen/heart_screen.dart';
import 'package:cdsf/service/bottom_nav_service.dart';
import 'package:cdsf/service/heart_service.dart';
import 'package:cdsf/widget/bottom_navigation_bar_widget.dart';
import 'package:cdsf/widget/floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WIZPICK',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo),
          onPressed: () {
            context.read<BottomNavService>().goHome();
            Navigator.pushNamed(context, '/start');
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '추천 방법을 선택해 주세요!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keyword_pick');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.indigo,
                          side: BorderSide(color: Colors.indigo),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.zero,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Container(
                          width: 160,
                          height: 160,
                          alignment: Alignment.center,
                          child: Text(
                            'KEY WORD\nPICK !',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/search_pick');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.zero,
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Container(
                          width: 160,
                          height: 160,
                          alignment: Alignment.center,
                          child: Text(
                            'SEARCH\nPICK !',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ImagePopup(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 167, 178, 241),
                            Color.fromARGB(255, 95, 112, 207),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        'WIZPICK 사용 가이드✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String url =
                          "https://www.scnu.ac.kr/SCNU/na/ntt/selectNttInfo.do?nttSn=281150855&mi=1131&currPage=1&listCo=10&searchType=sj&nttSttus=&searchValue=%EA%B0%9C%EC%84%A4";
                      launch(url);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.indigo),
                        color: Colors.white,
                      ),
                      child: Text(
                        '2023 개설 교양 과목✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String url =
                          "https://www.scnu.ac.kr/haksa/cm/cntnts/cntntsView.do?mi=1423&cntntsId=1289";
                      launch(url);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Container(
                      width: 350,
                      height: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 167, 178, 241),
                            Color.fromARGB(255, 95, 112, 207),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        '2023 SCNU 교육과정 🔍',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWidget(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: context.watch<BottomNavService>().currentIndex,
      ),
    );
  }
}

class ImagePopup extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/001.jpg',
    'assets/002.jpg',
    'assets/003.jpg',
    'assets/004.jpg',
    'assets/005.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                children: imagePaths.map((path) => Image.asset(path)).toList(),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
              label: Text("닫기"),
            ),
          ],
        ),
      ),
    );
  }
}
