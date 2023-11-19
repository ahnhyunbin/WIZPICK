import 'package:cdsf/model/course_model.dart';
import 'package:cdsf/service/bottom_nav_service.dart';
import 'package:cdsf/service/heart_service.dart';
import 'package:cdsf/service/keyword_service.dart';
import 'package:cdsf/widget/bottom_navigation_bar_widget.dart';
import 'package:cdsf/widget/floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  final String screenType;

  ResultScreen({super.key, required this.screenType});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final recommendedCourses =
        context.watch<KeywordService>().recommendedCourses;
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          ..._subTitle(),
          ..._recommendList(recommendedCourses),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: context.watch<BottomNavService>().currentIndex,
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text(
        widget.screenType == 'keyword' ? 'KEYWORD PICK 결과' : 'SEARCH PICK 결과',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.indigo,
      ),
    );
  }

  // 'KEYWORD 추천 교양✨ or '검색 추천 교양✨'
  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        widget.screenType == 'keyword' ? 'KEYWORD 추천 교양✨' : '검색 추천 교양✨',
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }

  List<Widget> _subTitle() {
    return widget.screenType == 'keyword'
        ? [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                '메인 키워드 - ${context.read<KeywordService>().mainKeyWords[context.read<KeywordService>().mainKeywordIndex]}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Row(
                children: [
                  Text(
                    '서브 키워드 - ',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  ...context.read<KeywordService>().subKeywordIndices.map((e) {
                    return Text(
                      ' ${context.read<KeywordService>().subKeyWords[e]}  ',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ]
        : [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Text(
                '내가 선택한 교양과목 - ${context.read<KeywordService>().selectedCourseName}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ];
  }

  List<Widget> _recommendList(List<CourseModel> recommendedCourses) {
    return [
      Expanded(
        child: ListView.builder(
          itemCount: recommendedCourses.length,
          itemBuilder: (context, index) {
            Color cardColor =
                (index % 2 == 0) ? Colors.indigo[50]! : Colors.white;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                color: cardColor,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          recommendedCourses[index].courseName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            recommendedCourses[index].isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: recommendedCourses[index].isFavorite
                                ? Colors.indigo
                                : Colors.indigo,
                          ),
                          onPressed: () async {
                            await context
                                .read<HeartService>()
                                .toggleIsFavorite(recommendedCourses[index].id);
                            await context
                                .read<KeywordService>()
                                .getRecommendedCourses();
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          recommendedCourses[index].courseType,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            recommendedCourses[index].courseContent,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }
}
