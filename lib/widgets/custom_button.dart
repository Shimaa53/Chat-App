import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,required this.text, this.onTap});
String text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0)
        ),
        width: double.infinity,
        height: 60.0,
        child: Center(child: Text(text),
      )
      ),
    );
  }
}
