import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CustomChatBuble extends StatelessWidget {
   CustomChatBuble({super.key,required this.message});
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric( horizontal: 16.0,vertical: 8.0),
        padding: const EdgeInsets.only(left: 16.0,top: 16.0,bottom: 16.0,right: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32),
            topRight:Radius.circular(32),
            bottomRight:Radius.circular(32),),
          color: kPrimaryColor,
        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white
          ),),
      ),
    );
  }
}

class CustomChatBubleForFriend extends StatelessWidget {
  CustomChatBubleForFriend({super.key,required this.message});
  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric( horizontal: 16.0,vertical: 8.0),
        padding: const EdgeInsets.only(left: 16.0,top: 16.0,bottom: 16.0,right: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(32),
            topRight:Radius.circular(32),
            bottomLeft:Radius.circular(32),),
          color: Colors.grey,
        ),
        child: Text(message.message,
          style: const TextStyle(
              color: Colors.white
          ),),
      ),
    );
  }
}
