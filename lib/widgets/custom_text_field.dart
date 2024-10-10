import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({super.key,this.hintText,this.onChanged,this.obsecureText=true});
String? hintText;
Function(String)? onChanged;
bool obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged: onChanged,
      obscureText: obsecureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
