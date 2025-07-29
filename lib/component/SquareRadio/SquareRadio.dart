import 'package:flutter/material.dart';

class SquareRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final bool selected;
  final bool completed;
  final ValueChanged<T> onChanged;
  final double size;
  final Color selectedColor;
  final Color unselectedColor;

  const SquareRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.selected,
    required this.completed,
    required this.onChanged,
    this.size = 24,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: selected || completed ? selectedColor : Colors.transparent,
          border: Border.all(
            color: selected || completed ? selectedColor : unselectedColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: selected || completed
            ? Icon(Icons.check, size: size * 0.7, color: Colors.white)
            : null,
      ),
    );
  }
}
