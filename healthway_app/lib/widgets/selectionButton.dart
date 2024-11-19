import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const SelectionButton({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: isSelected ? Colors.blue : Colors.blue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text),
    );
  }
}
