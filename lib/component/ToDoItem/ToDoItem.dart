import 'package:flutter/material.dart';
import 'package:mobile1/component/SquareRadio/SquareRadio.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/component/UpdateItem/UpdateItem.dart';
import 'package:mobile1/api/network/todo.service.dart';
import 'package:mobile1/layout/tabs/TodoDetailTab.dart';

class ToDoItem extends StatefulWidget {
  final Size mediaQuery;
  late String? id;
  final String? title;
  final String? description;
  final IToDoItem item;
  final List<IToDoItem>? todos;

  ToDoItem({
    super.key,
    required this.mediaQuery,
    required this.title,
    required this.description,
    required this.id,
    required this.item,
    required this.todos,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  String _selectedItem = "0";
  late bool isSelected = false;
  late Future<Response> futureResponse;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: widget.mediaQuery.width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black45)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: SquareRadio<String>(
              size: 36,
              value: widget.id!,
              groupValue: _selectedItem,
              selected: isSelected,
              completed: widget.item.completed!,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                  isSelected = true;
                  if (widget.item.completed == false) {
                    Map<String, dynamic> completeDto = {
                      'completed': isSelected,
                    };
                    int ids = int.parse(widget.id!);
                    completedToDo(completeDto, ids);
                    fetchResponse();
                  }
                });
              },
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: mediaQuery.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoDetailTab(
                          mediaQuery: mediaQuery,
                          todo: widget.item,
                        ),
                      ),
                    );
                    print('Ontap me');
                  },
                  child: Text(
                    widget.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      decoration: widget.item.completed!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                Text(
                  widget.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    textBaseline: TextBaseline.alphabetic,
                    decoration: widget.item.completed!
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
                  if (widget.item.completed! == true)
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
                                Map<String, dynamic> statusDto = {
                                  'status': true,
                                };
                                int ids = int.parse(widget.id!);
                                setState(() {
                                  removeToDo(statusDto, ids);
                                  fetchResponse();
                                });
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
                  color: widget.item.completed! ? Colors.red : Colors.red[100],
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
                              item: widget.item,
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
                                  Map<String, dynamic> updateDto = {
                                    'title': title,
                                    'description': description,
                                  };
                                  int ids = int.parse(widget.id!);
                                  setState(() {
                                    updateToDo(updateDto, ids);
                                    fetchResponse();
                                  });
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
                  color: widget.item.completed!
                      ? Colors.purple[100]
                      : Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
