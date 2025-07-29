import 'package:flutter/material.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/component/Collapsible/Collapsible.dart';

class SystemTab extends StatelessWidget {
  const SystemTab({
    super.key,
    required this.futureResponse,
    required this.mediaQuery,
  });

  final Future<Response> futureResponse;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    List<IToDoItem> completedTodos = [];
    List<IToDoItem> pendingTodos = [];
    List<IToDoItem> canceledTodos = [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: SingleChildScrollView(
        child: FutureBuilder<Response>(
          future: futureResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var todo in snapshot.data!.data!) {
                if (todo.status == true) {
                  canceledTodos.add(todo);
                } else {
                  if (todo.completed == true) {
                    completedTodos.add(todo);
                  } else if (todo.completed == false) {
                    pendingTodos.add(todo);
                  }
                }
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Solution',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                Collapsible(
                  mediaQuery: mediaQuery,
                  title: 'Todos completed',
                  todos: completedTodos,
                  color: Colors.green,
                ),
                Collapsible(
                  mediaQuery: mediaQuery,
                  title: 'Todos un completed',
                  todos: pendingTodos,
                  color: Colors.black87,
                ),
                Collapsible(
                  mediaQuery: mediaQuery,
                  title: 'Todos canceled',
                  todos: canceledTodos,
                  color: Colors.red,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
