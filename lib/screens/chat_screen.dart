// ignore_for_file: prefer_const_constructors

import 'package:chatapp/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/cubit/chat_cubit/chat_state.dart';
import 'package:chatapp/widgets/constans.dart';
import 'package:chatapp/widgets/widget_chat_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String uID = '${FirebaseAuth.instance.currentUser?.uid}';

// ignore: use_key_in_widget_constructors, must_be_immutable
class ChatScreen extends StatelessWidget {
  static String iD = 'Chat Screen';
  String? date;

  final TextEditingController _control = TextEditingController();
  final _controller = ScrollController();
  String email = '${FirebaseAuth.instance.currentUser!.email}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ChatCubit, ChatStates>(
                builder: (context, state) {
                  return Text(
                    BlocProvider.of<ChatCubit>(context).getDate(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
        backgroundColor: kPrimareColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatStates>(
              builder: (context, state) {
                var messageList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? ChatBubleWidget(
                            message: messageList[index],
                          )
                        : ChatBubleFriendWidget(
                            message: messageList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: data,
                  email: email,
                );
                _control.clear;
                _controller.jumpTo(
                  0,
                );
              },
              decoration: InputDecoration(
                labelText: 'Message',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: kPrimareColor,
                  ),
                  onPressed: () {
                    // controller.clear();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
