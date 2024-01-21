import 'package:chat_app/constant/const.dart';
import 'package:chat_app/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
   ChatScreen({super.key});

  static String id = 'ChatPage';
   @override
  State<ChatScreen> createState() => _ChatScreenState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference messages = FirebaseFirestore.instance.collection('messages');


class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(KLogo,
            height: 50,
            ),
            Text('Scholar chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (context,index){
              return ChatBubble();
            }),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onSubmitted: (data){
                messages.add({
                  'message':data
                });
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(Icons.send,
                  color: KPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: KPrimaryColor,
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
