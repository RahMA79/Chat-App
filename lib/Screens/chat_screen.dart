import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ScrollController _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messgesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messgesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: const Color(0xffF3F6F8),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xffF3F6F8),
                title: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/Logo.PNG'),
                          height: 60,
                        ),
                        Text(
                          'Chats',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messgesList.length,
                        itemBuilder: (context, index) {
                          return messgesList[index].id == email
                              ? ChatBubble(
                                  message: messgesList[index],
                                )
                              : ChatBubbleForFriend(
                                  message: messgesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'id': email
                        });
                        _controller.animateTo(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                        controller.clear();
                      },
                      decoration: InputDecoration(
                          hintText: 'Send message',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Montserrat'),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              final text = controller.text;
                              if (text.isNotEmpty) {
                                // Simulate the onSubmitted functionality
                                messages.add({
                                  'message': text,
                                  'createdAt': DateTime.now(),
                                  'id': email,
                                });
                                _controller.animateTo(
                                  _controller.position.maxScrollExtent,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                );
                                controller.clear();
                              }
                            },
                            child: const Icon(
                              Icons.send,
                              color: primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(24),
                          )),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Lottie.asset(
                  'assets/chat_animation1.json',
                ),
              ),
            );
          }
        });
  }
}
