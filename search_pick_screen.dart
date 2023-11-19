import 'package:cdsf/screen/result_screen.dart';
import 'package:cdsf/service/bottom_nav_service.dart';
import 'package:cdsf/service/keyword_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPickScreen extends StatefulWidget {
  @override
  _SearchPickScreenState createState() => _SearchPickScreenState();
}

class _SearchPickScreenState extends State<SearchPickScreen> {
  String _searchText = ''; // 검색어를 저장할 변수
  bool _isLoading = false; // 로딩 중인지 나타내는 변수

  // 검색 가능한 교양 목록
  final List<String> selectCourses = [
    '대학생활과목표설정',
    '독서와표현',
    '사고와글쓰기',
    '정량적사고와컴퓨팅사고',
    '문학과삶',
    '현대예술문화',
    '한국의역사',
    '철학산책',
    '글로벌시민정치',
    '경제의이해',
    '사회학입문',
    '법과인권',
    '심리학이해',
    '대학교양수학',
    '물리학의이해',
    '생활속의화학적사고',
    '생물학으로의산책',
    '지구와환경',
    '커뮤니케이션영어',
    '커뮤니케이션중국어',
    '커뮤니케이션일본어',
    '흙에서배우는삶의지혜',
    '스포츠활동과인성개발',
    '음악하기로배우는삶',
    '따뜻한수화와언어의마음',
    '순천한바퀴',
    '기본수학',
    '한국의문화유산',
    '한국고전문학명작산책',
    '한국현대문학의이해',
    '동양사상의이해',
    '종교의이해',
    '현대대중문화와예술',
    '문학개론',
    '언어학개론',
    '동양의역사와문화',
    '서양의역사와문화',
    '현대사회와스포츠',
    '문화인류학개론',
    '공연예술의이해',
    '현대예술의이해',
    '미술의이해',
    '논리와사고',
    '예술과미학',
    '음악으로세상읽기',
    '동아시아인의삶과사상',
    '이공계생을위한인문학',
    '패션과에로티시즘',
    '정원예술과문화의이해',
    '융합예술로보는패션여행',
    '전남동부지역의이해',
    '시로읽는세상',
    '유튜브의이해',
    '동물과룸메이트',
    '만화의이해',
    '영미문학으로보는사랑',
    '영화로알아보는스포츠의이해',
    '경제학개론',
    '커뮤니케이션회계',
    '사회적경제를통한상생문화',
    '무역문명사의이해',
    '북한의정치와사회',
    '호남의역사와문화',
    '다문화사회와다문화교육',
    '여성학개론',
    '경영의이해',
    '직업세계와법',
    '세계문화를통한상관습엿보기',
    '남도의정원문화',
    '법학의이해',
    '정치학의이해',
    '지리학탐색',
    '무역을통한세상읽기',
    '물류의이해',
    '지역산업의이해',
    '행정학의이해',
    '평생학습진로설계',
    '자유론',
    '도시발전과지역의미래',
    '국제개발협력과글로벌사회봉사의이해',
    '전쟁의 역사',
    '북한학',
    '리더쉽',
    '영화로이해하는글로벌비즈니스',
    '지속가능성과 ESG',
    '미디어로이해하는기업전략',
    '사회적경제와소셜리빙랩',
    '스마트외식과소비자',
    '유럽의언어와문화',
    '동물자원과인간의생활',
    '자바프로그래밍',
    '파이썬과컴퓨터알고리즘',
    'SW를통한사회과학문제해결',
    '이공학도를위한매트랩인문',
    '발명과특허',
    '생태계와환경오염',
    '농업의현재와미래',
    '생명공학과인류의미래',
    '인터넷과정보윤리',
    '건강과환경질병관리',
    '대학수학',
    '일반물리학',
    '일반화학',
    '일반생물학',
    '컴퓨터의개념및실습',
    '지구과학',
    '물리학및실험',
    '화학및실험',
    '생물학및실험',
    '지구과학및실험',
    '슬로푸드이야기',
    '창의적문제해결방법론',
    '프레젠테이션스토리와발표',
    'IT통합기술과미래교육',
    '디지털디자인',
    '통계학입문',
    '물리학의세계',
    '식물과인간의공생',
    '금융이야기',
    '컴퓨터프로그래밍및실습',
    '데이터과학의이해',
    '인공지능의이해',
    '영어읽기와프리젠테이션',
    '영어읽기와글쓰기',
    '한일대중문화의이해를통한소통',
    '자연과학글쓰기',
    '영어작문',
    '중국어입문',
    '일본어입문',
    '비즈니스영어',
    '대학영어',
    '영어회화',
    '대학한문',
    'TED를통해배우는커뮤니케이션',
    '대학글쓰기',
    '기초중국어',
    '기초일본어',
    '영화와토론',
    '생활일본어회화',
    '생활중국어회화',
    '인문학으로배우는소통',
    '한자의이해',
    '인문학과자연과학의만남',
    '생명환경정보윤리',
    '유전과진화의이해',
    '식품과건강',
    '인류생활과환경이슈',
    '영상으로보는인간경험과학습',
    '스마트의류디자인',
    '혁명을꿈꾸는미생물',
    '미래사회의예측과변화',
    '환경호르몬의역습',
    '기후변화와녹색도시',
    '에코지능과지속가능한미래',
    '숲과문화와산림치유',
    '문명과함께하는기술',
    '과학과디자인이함께하는3D프린팅',
    '과학사의뒷이야기와현대문화',
    '아시아공동체론',
    '소비와윤리',
    '과학기술세상에서의삶',
    '영화와책속의생명과학이야기',
    '세상을바꾼천연물이야기',
    '지구환경과숲의역할',
    '10억달러분자',
    '스마트농식품산업입문',
    '역사속의과학이야기',
    '신기한식물세계와인류의역사이야기',
    '여행보건학',
    '코딩과융복합교육',
    '과학,인간,기술,사회의이해',
    '청년창업의이해',
    '4차산업혁명과푸드테크창업',
    '행복한뇌와불타는뉴런',
    '한약과건강',
    '공존의심리학',
    '탄소중립과미래사회',
    '기후소양',
    '인간뇌과학을통한자기계발',
    '자기개발과진로설정',
    '취업과진로',
    '벤처창업',
    '창업과진로',
    '창업가정신',
    '기업가정신',
    '인성교육론',
    '창업경영의이해',
    '창의적창업아이디어개발',
    '창업의이해',
    '기업직업의이해',
    '나의미래디자인',
  ];

  List<String> selectedCourses = [];

  List<String> _filterCourses(String searchText) {
    return selectCourses.where((course) {
      return course.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  Future<void> _handleSearch() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });

    if (selectedCourses.isNotEmpty) {
      await Navigator.pushNamed(
        context,
        '/searchprint',
        arguments: selectedCourses,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text('선택한 교양이 없습니다.\n교양을 선택해주세요.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredCourses = _filterCourses(_searchText);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SEARCH PICK',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0),
            Text(
              '교양 과목을 검색해주세요✨',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            SizedBox(height: 10.0),
            Text(
              '입력한 교양 과목과 유사한 과목을 검색합니다\n검색하지 않고도 스크롤하여 선택할 수 있습니다',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '검색어 입력',
                hintText: '교양 주제나 키워드를 입력하세요',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        final course = filteredCourses[index];
                        final isSelected = selectedCourses.contains(course);

                        return ListTile(
                          title: Text(course),
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedCourses.remove(course);
                              } else {
                                selectedCourses.clear();
                                selectedCourses.add(course);
                              }
                            });
                          },
                          trailing:
                              isSelected ? Icon(Icons.check_circle) : null,
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.indigo,
                  side: BorderSide(color: Colors.indigo, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if (selectedCourses.isNotEmpty) {
                    setState(() {
                      _isLoading = true;
                    });
                    await Future.delayed(Duration(seconds: 2));

                    await context
                        .read<KeywordService>()
                        .getSearchRecommendations(selectedCourses[0]);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          screenType: 'search',
                        ),
                      ),
                    );

                    setState(() {
                      _isLoading = false;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('알림'),
                          content: Text('선택한 교양이 없습니다.\n교양을 선택해주세요.'),
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
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('선택한 교양으로 추천 받기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
