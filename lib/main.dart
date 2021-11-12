import 'package:chef_syncfusion/event_editing_page.dart';
import 'package:chef_syncfusion/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_Widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Chef Calendar';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.white,
        primaryColor: Colors.red
      ),
      home: MainPage(),
      ));
  }
}
class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(MyApp.title),
      ),
      body: CalenderWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventEditingPage())
        )
      ),
    );
  }
}
