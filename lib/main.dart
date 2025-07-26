import 'package:flutter/material.dart';
import 'package:mobile1/component/AddItem/AddItem.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/component/ToDoItem/ToDoItem.dart';
import 'package:mobile1/api/abs/IAddToDo.dart';
import 'package:mobile1/api/network/service.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Todo Applicant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Response> futureResponse;
  late Future<IAddToDo> _futureNewToDo;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureResponse = fetchResponse();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    print('futureResponse: ${futureResponse.hashCode}');

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: FutureBuilder<Response>(
            future: futureResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<IToDoItem> todos = [];
                for (var todo in snapshot.data!.data!) {
                  if (todo.status! == false) {
                    todos.add(todo);
                  }
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      todos.isNotEmpty
                          ? ''
                          : 'Bạn chưa có công việc nào được tạo. Hãy tạo công việc!!!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: mediaQuery.width,
                      height: mediaQuery.height,
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: ToDoItem(
                              mediaQuery: mediaQuery,
                              title: todos[index].title,
                              description: todos[index].description,
                              id: '${todos[index].id}',
                              item: todos[index],
                              todos: todos,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.lightBlue,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1.0,
                          style: BorderStyle.solid,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator(
                color: Colors.lightBlue,
                strokeWidth: BorderSide.strokeAlignInside,
                value: 30,
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Thêm công việc',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
