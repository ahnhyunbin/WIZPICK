import 'package:cdsf/service/bottom_nav_service.dart';
import 'package:cdsf/service/heart_service.dart';
import 'package:cdsf/service/keyword_service.dart';
import 'package:cdsf/widget/bottom_navigation_bar_widget.dart';
import 'package:cdsf/widget/floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartScreen extends StatelessWidget {
  HeartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _favoriteCourses = context.watch<HeartService>().favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.indigo),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.indigo),
          onPressed: () {
            context.read<BottomNavService>().goHome();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'LIKE LIST 💙',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _favoriteCourses.length,
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
                        _favoriteCourses[index].courseName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _favoriteCourses[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _favoriteCourses[index].isFavorite
                              ? Colors.indigo
                              : Colors.indigo,
                        ),
                        onPressed: () async {
                          await context
                              .read<HeartService>()
                              .toggleIsFavorite(_favoriteCourses[index].id);
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        _favoriteCourses[index].courseType,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          _favoriteCourses[index].courseContent,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: context.watch<BottomNavService>().currentIndex,
      ),
    );
  }
}
