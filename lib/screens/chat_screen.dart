import 'package:chat_app/widgets/constants.dart';
import 'package:chat_app/widgets/custom_chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});
 static String id='ChatScreeen';
   CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
   TextEditingController controller=TextEditingController();
   final ScrollController _controller = ScrollController();

   @override
  Widget build(BuildContext context) {
    var email= ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Message>messageList=[];
            for(int i=0;i<snapshot.data!.docs.length;i++){
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(kLogo,height: 50,width: 50,),
                      const Text('Chat',style: TextStyle(
                          color: Colors.white
                      ),),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messageList.length,
                            itemBuilder: (context,index) {
                            return messageList[index].id == email ?
                              CustomChatBuble(message: messageList[index])
                                  :CustomChatBubleForFriend(message: messageList[index]);
                            })),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data){
                          messages.add({
                            kMessage :data,
                            kCreatedAt:DateTime.now(),
                            'id':email
                          });
                          controller.clear();
                          _controller.animateTo(
                              0,
                              duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,);
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.send,color: kPrimaryColor,),
                          hintText: 'Send Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                  color: kPrimaryColor
                              )
                          ),

                        ),
                      ),
                    )
                  ],
                )
            );

        }else{
            return const Text('Loading....');
          }
        });
     }
}
