import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label; // The label on the button
  final VoidCallback onPressed; // Action to perform on press

  const ActionButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // You can customize the color
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
