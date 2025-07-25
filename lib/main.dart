import 'package:flutter/material.dart';
import 'package:mobile1/component/AddItem/AddItem.dart';
import 'package:mobile1/component/ToDoItem/IToDoItem.dart';
import 'package:mobile1/component/ToDoItem/ToDoItem.dart';

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
  final todos = List.generate(
    5,
    (i) =>
        IToDoItem('Todo $i', 'A description of what needs to be done for Todo'),
  );

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void handleRemoveItem(id) {
    setState(() {
      todos.removeAt(id);
    });
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                        id: '${index + 1}',
                        remove: handleRemoveItem,
                        todos: todos,
                      ),
                    );
                  },
                ),
              ),
            ],
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
                    todos.add(IToDoItem(title, description));
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
