import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  MyButton({
    required this.color,
    required this.title,
    required this.onPressed
  });
  final Color color;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      //لاضافه مسافه من فوق و تحت
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color:color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(onPressed: onPressed,
          minWidth: 200,
          height: 40,
          child: Text(title,
            style: TextStyle(
              color: Colors.white,
            ),),
        ),
      ),
    );}}