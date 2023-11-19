import 'package:cdsf/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/memo_service.dart';

class Memoscreen extends StatelessWidget {
  const Memoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "MEMO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.indigo,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: memoList.isEmpty
              ? Center(child: Text("메모를 작성해 주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    Memo memo = memoList[index];
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(
                          memo.isPinned
                              ? CupertinoIcons.pin_fill
                              : CupertinoIcons.pin,
                          color: memo.isPinned ? Colors.indigo : null,
                        ),
                        onPressed: () {
                          memoService.togglePin(index);
                        },
                      ),
                      title: Text(
                        memo.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.add),
            onPressed: () {
              memoService.createMemo(content: '');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    index: memoService.memoList.length - 1,
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.index});

  final int index;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
        actions: [
          IconButton(
            onPressed: () {
              showDeleteDialog(context, memoService);
            },
            icon: Icon(Icons.delete, color: Colors.indigo),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: "메모를 입력하세요",
            border: InputBorder.none,
          ),
          autofocus: true,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            memoService.updateMemo(index: index, content: value);
          },
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                memoService.deleteMemo(index: index);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BottomAppBar(
        notchMargin: 12,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      );
}
