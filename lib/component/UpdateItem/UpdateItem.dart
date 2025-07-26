import 'package:flutter/material.dart';
import 'package:mobile1/api/abs/IToDoItem.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({
    super.key,
    required this.mediaQuery,
    required this.item,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  }) : _titleController = titleController,
       _descriptionController = descriptionController;

  final Size mediaQuery;
  final IToDoItem item;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._titleController.text = widget.item.title ?? "";
    widget._descriptionController.text = widget.item.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    print('item: ${widget.item.title}');

    return SizedBox(
      height: widget.mediaQuery.height * 0.16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: _titleFocusNode,
            keyboardAppearance: Brightness.light,
            keyboardType: TextInputType.emailAddress,
            controller: widget._titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.item.title,
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              if (!_titleFocusNode.hasFocus) {
                _titleFocusNode.requestFocus();
              }
            },
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          TextField(
            focusNode: _descriptionFocusNode,
            keyboardAppearance: Brightness.light,
            keyboardType: TextInputType.emailAddress,
            controller: widget._descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.item.description,
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              if (!_descriptionFocusNode.hasFocus) {
                _descriptionFocusNode.requestFocus();
              }
            },
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
