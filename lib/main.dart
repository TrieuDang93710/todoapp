import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile1/component/AddItem/AddItem.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/api/abs/IAddToDo.dart';
import 'package:mobile1/api/network/todo.service.dart';
import 'package:mobile1/layout/tabs/MainTab.dart';
import 'package:mobile1/layout/tabs/SystemTab.dart';
import 'package:mobile1/layout/tabs/TodoDetailTab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: DefaultTabController(
        length: 3,
        child: const MyHomePage(title: 'Todo Applicant'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Future<Response> futureResponse;
  late Future<IAddToDo> _futureNewToDo;
  late TabController _tabController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureResponse = fetchResponse();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.index = 0;
    _tabController.addListener(() {});
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Colors.deepOrange,
          ),
        ),
        bottom: TabBar(
          indicatorColor: Colors.purpleAccent,
          indicatorPadding: const EdgeInsets.symmetric(vertical: 2.0),
          onTap: (value) => _tabController.animateTo(value),
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.check_box, size: 36, color: Colors.deepPurple),
            ),
            Tab(
              icon: Icon(Icons.bar_chart, size: 36, color: Colors.deepPurple),
            ),
            Tab(icon: Icon(Icons.settings, size: 36, color: Colors.deepPurple)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          controller: _tabController,
          children: [
            MainTab(futureResponse: futureResponse, mediaQuery: mediaQuery),
            SystemTab(futureResponse: futureResponse, mediaQuery: mediaQuery),
            Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _tabController.index > 0
          ? null
          : FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Thêm công việc',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    content: AddItem(
                      mediaQuery: mediaQuery,
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _titleController.clear();
                          _descriptionController.clear();
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String title = _titleController.text;
                          String description = _descriptionController.text;

                          Map<String, dynamic> todoDto = {
                            'title': title,
                            'description': description,
                          };
                          setState(() {
                            _futureNewToDo = createToDo(todoDto);
                            fetchResponse();
                          });
                          Navigator.of(context).pop();
                          _titleController.clear();
                          _descriptionController.clear();
                        },
                        child: Text(
                          'Lưu',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
    );
  }
}
