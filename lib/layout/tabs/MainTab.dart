import 'package:flutter/material.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/component/ToDoItem/ToDoItem.dart';

class MainTab extends StatelessWidget {
  const MainTab({
    super.key,
    required this.futureResponse,
    required this.mediaQuery,
  });

  final Future<Response> futureResponse;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
