import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  static bool isInitialMessageAdded = false; // <-- 새로운 변수 추가

  @override
  void initState() {
    super.initState();

    // initState에서 메시지를 한 번만 추가하기 위한 조건 추가
    if (!isInitialMessageAdded) {
      _addChatBotMessage(
          '안녕하세요! 저는 챗봇입니다.\n무엇을 도와드릴까요?\n\n추천 질문을 몇 가지 제시합니다!\n1. WIZPICK의 작품의도\n2. 교양 추천 과정이 궁금해요!\n3. 두 가지의 추천 방법의 차이점은?\n\n궁금한 내용을 작성하거나\n1, 2, 3번을 입력해주세요.\n\n이 외에도 간단한 대화가 가능합니다!');
      isInitialMessageAdded = true; // <-- 메시지 추가 후 상태 업데이트
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
        title: Text(
          'CHATBOT 💬',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 8,
            child: ListView(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              physics: BouncingScrollPhysics(),
              children: _messages,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 9,
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: '메시지를 입력하세요',
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.indigo,
                ),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    _handleBotResponse(text);
  }

  void _handleBotResponse(String userMessage) {
    String response = '죄송해요, 이해하지 못했어요.';

    if (userMessage.toLowerCase().contains('안녕') ||
        userMessage.toLowerCase().contains('hi') ||
        userMessage.toLowerCase().contains('하이') ||
        userMessage.toLowerCase().contains('ㅎㅇ') ||
        userMessage.toLowerCase().contains('hello')) {
      response = '안녕하세요! 😊';
    } else if (userMessage.toLowerCase() == '날씨') {
      response = '오늘 날씨는 맑습니다.';
    } else if (userMessage.toLowerCase().contains('작품 의도') ||
        userMessage.toLowerCase() == '1번' ||
        userMessage.toLowerCase() == '1' ||
        userMessage.toLowerCase().contains('제작 의도') ||
        userMessage.toLowerCase().contains('의도')) {
      response =
          '우리학교 재학생들이 교양과목에 대한 관심이 많이 떨어진다고 느껴졌고, 교양 추천 프로그램을 개발한다면 누구나 쉽게 교양을 접하고 추천 받으면 도움이 될 수 있겠다는 생각에 제작하게 되었어!';
    } else if (userMessage.toLowerCase().contains('추천 과정') ||
        userMessage.toLowerCase() == '2번' ||
        userMessage.toLowerCase() == '2' ||
        userMessage.toLowerCase().contains('과정') ||
        userMessage.toLowerCase().contains('추천')) {
      response =
          '교양 추천 과정은 키워드 추출로 진행하고 있어. 각 교양마다 키워드 추출을 통해 메인키워드1개, 서브키워드5개를 부여해. 그렇기 때문에 키워드를 선택해서 교양을 추천받을 수 있고, 교양을 선택하면 선택한 교양과 비슷한 키워드를 가진 교양을 추천 할 수도 있어.';
    } else if (userMessage.toLowerCase().contains('차이점') ||
        userMessage.toLowerCase() == '3번' ||
        userMessage.toLowerCase() == '3' ||
        userMessage.toLowerCase().contains('차이') ||
        userMessage.toLowerCase().contains('방법')) {
      response =
          '두 가지 추천 방법의 차이점은 키워드를 선택하냐, 교양을 선택하냐에 따라 다르게 볼 수 있어. 키워드 기반 추천은 내가 관심있는 키워드를 누르면 키워드에 맞게 추천해주고, 검색 기반 추천은 내가 관심있는 교양을 선택하면 선택한 교양과 비슷한 교양을 추천해주는거야! ';
    } else if (userMessage.toLowerCase().contains('좋아하는 음식')) {
      response = '저는 음식을 먹지 않지만, 피자와 파스타가 맛있어 보여요!';
    } else if (userMessage.toLowerCase().contains('휴가 어때요?')) {
      response = '저는 항상 열심히 일하고 있어서 휴가는 없어요. 😅';
    } else if (userMessage.toLowerCase().contains('무슨 일을 하나요?')) {
      response = '저는 채팅 대화를 위해 만들어진 가상 로봇이에요!';
    }

    _addChatBotMessage("챗봇 응답: $response");
  }

  void _addChatBotMessage(String message) {
    ChatMessage chatBotMessage = ChatMessage(
      text: message,
      isUserMessage: false,
    );
    setState(() {
      _messages.insert(0, chatBotMessage);
    });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          isUserMessage
              ? Container()
              : CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '\nWIZ',
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        'PICK',
                        style: TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            margin: const EdgeInsets.only(left: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.indigo[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
