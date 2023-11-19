import 'package:cdsf/screen/result_screen.dart';
import 'package:cdsf/service/keyword_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeywordPickScreen extends StatefulWidget {
  @override
  _KeywordPickScreenState createState() => _KeywordPickScreenState();
}

class _KeywordPickScreenState extends State<KeywordPickScreen> {
  int _selectedButtonIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KEYWORD PICK',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              '관심 키워드를 선택해주세요✨',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            SizedBox(height: 5),
            Text(
              'MAIN KEYWORD 선택',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2.0),
            Text(
              '추천 받고 싶은 분야의 키워드를 선택해주세요!\nMAIN KEYWORD는 한 개만 선택 가능합니다',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                final List<String> keywords = [
                  '자기개발,\n인성',
                  '인문,예술',
                  '과학,공학,\nICT',
                  '지역,사회',
                  '의사소통,\n외국어',
                  '융복합',
                  '전체',
                ];
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedButtonIndex = index;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _selectedButtonIndex == index
                        ? Colors.indigo
                        : Colors.white,
                    onPrimary: _selectedButtonIndex == index
                        ? Colors.white
                        : Colors.indigo,
                    side: BorderSide(color: Colors.indigo),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    keywords[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _selectedButtonIndex == index
                          ? Colors.white
                          : Colors.indigo,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ElevatedButton(
            onPressed: () {
              // 메인 키워드 선택 확인
              if (_selectedButtonIndex == -1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('알림'),
                      content: Text('메인 키워드를 선택해주세요.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('확인'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                context.read<KeywordService>().mainKeywordIndex =
                    _selectedButtonIndex;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubKeywordPickScreen()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              side: BorderSide(color: Colors.indigo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              '다음',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class SubKeywordPickScreen extends StatefulWidget {
  @override
  _SubKeywordPickScreenState createState() => _SubKeywordPickScreenState();
}

class _SubKeywordPickScreenState extends State<SubKeywordPickScreen> {
  List<int> _selectedButtonIndices = [];
  bool _isRecommendationLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KEYWORD PICK',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
      ),
      body: _isRecommendationLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '관심 키워드를 선택해주세요!',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'SUB KEYWORD 선택',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    '추천 받고 싶은 분야의 키워드를 선택해주세요!\nSUB KEYWORD를 3개 선택해주세요',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      final List<String> keywords = [
                        '사회적\n상호작용',
                        '문화 이해',
                        '논리적 사고',
                        '분석적 사고',
                        '비판적 사고',
                        '창의적 사고',
                        '의사소통\n능력',
                        '정의/윤리',
                        '기술 활용',
                        '리더십',
                        '글로벌 시각',
                        '미래지향적 사고',
                        '문제해결',
                        '실무능력',
                      ];
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedButtonIndices.contains(index)) {
                              _selectedButtonIndices.remove(index);
                            } else {
                              if (_selectedButtonIndices.length < 3) {
                                _selectedButtonIndices.add(index);
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: _selectedButtonIndices.contains(index)
                              ? Colors.indigo[700]
                              : Colors.white,
                          side: BorderSide(
                            color: Colors.indigo,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          keywords[index],
                          style: TextStyle(
                              color: _selectedButtonIndices.contains(index)
                                  ? Colors.white
                                  : Colors.indigo,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              // 서브 키워드 선택 확인
              if (_selectedButtonIndices.length != 3) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('알림'),
                      content: Text('서브 키워드를 3개 선택해주세요.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('확인'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                context.read<KeywordService>().subKeywordIndices =
                    _selectedButtonIndices;

                setState(() {
                  _isRecommendationLoading = true;
                });

                await Future.delayed(Duration(seconds: 2));

                await context
                    .read<KeywordService>()
                    .getKeywordRecommendations();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      screenType: 'keyword',
                    ),
                  ),
                );

                setState(() {
                  _isRecommendationLoading = false;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              side: BorderSide(color: Colors.indigo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              '선택한 키워드로 추천 받기',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchRecommendations() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
