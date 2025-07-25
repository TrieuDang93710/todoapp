import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({
    super.key,
    required this.mediaQuery,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  }) : _titleController = titleController,
       _descriptionController = descriptionController;

  final Size mediaQuery;
  final TextEditingController _titleController;
  final TextEditingController _descriptionController;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
  Widget build(BuildContext context) {
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
              hintText: 'Nhập tên công việc',
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
              hintText: 'Nhập mô tả công việc',
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
