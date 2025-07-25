import 'package:flutter/material.dart';
import 'package:mobile1/component/SquareRadio/SquareRadio.dart';
import 'package:mobile1/component/ToDoItem/IToDoItem.dart';
import 'package:mobile1/component/UpdateItem/UpdateItem.dart';

class ToDoItem extends StatefulWidget {
  final Size mediaQuery;
  late String id;
  final String title;
  final String description;
  final List<IToDoItem> todos;
  final Function(int) remove;

  ToDoItem({
    super.key,
    required this.mediaQuery,
    required this.title,
    required this.description,
    required this.id,
    required this.remove,
    required this.todos,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  String _selectedItem = "0";
  late bool isSelected = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void handleUpdateItem(id, body) {
    int ids = int.parse(id) - 1;
    setState(() {
      for (int i = 0; i < widget.todos.length; i++) {
        if (i == ids) {
          widget.todos[i].title = body.title;
          widget.todos[i].description = body.description;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: widget.mediaQuery.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black45)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SquareRadio<String>(
            size: 36,
            value: widget.id,
            groupValue: _selectedItem,
            selected: isSelected,
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
                isSelected = true;
              });
            },
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    decoration: isSelected
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  widget.description,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    textBaseline: TextBaseline.alphabetic,
                    decoration: isSelected
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () => {
                  if (isSelected == true)
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Bạn có muốn xóa không?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                isSelected = true;
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
                                widget.remove(int.parse(widget.id) - 1);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Xóa',
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
                  isSelected = false,
                },
                child: Icon(
                  Icons.delete_forever,
                  size: 36,
                  color: isSelected ? Colors.red : Colors.red[100],
                ),
              ),
              SizedBox(width: 15),
              InkWell(
                onTap: () => {
                  if (isSelected == false)
                    {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Sửa công việc: ${widget.title}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            content: UpdateItem(
                              mediaQuery: mediaQuery,
                              titleController: _titleController,
                              descriptionController: _descriptionController,
                              item: IToDoItem(widget.title, widget.description),
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
                                  String description =
                                      _descriptionController.text;
                                  // todos.add(IToDoItem(title, description));
                                  handleUpdateItem(
                                    widget.id,
                                    IToDoItem(title, description),
                                  );
                                  Navigator.of(context).pop();
                                  _titleController.clear();
                                  _descriptionController.clear();
                                },
                                child: Text(
                                  'Sửa',
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
                    },
                  // isSelected = true,
                },
                child: Icon(
                  Icons.edit,
                  size: 36,
                  color: isSelected ? Colors.purple[100] : Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
