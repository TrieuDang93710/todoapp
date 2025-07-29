import 'package:flutter/material.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';

class Collapsible extends StatelessWidget {
  const Collapsible({
    super.key,
    required this.mediaQuery,
    required this.todos,
    required this.title,
    required this.color
  });

  final Size mediaQuery;
  final List<IToDoItem> todos;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
          ),
          maxLines: 1,
        ),
        children: [
          SizedBox(
            width: mediaQuery.width,
            height: mediaQuery.height,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  '${index + 1} - ${todos[index].title}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
