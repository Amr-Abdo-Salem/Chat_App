// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:chatapp/model/message_model.dart';
import 'package:chatapp/widgets/constans.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChatBubleWidget extends StatelessWidget {
  ChatBubleWidget({
    required this.message,
  });
  String date = DateFormat("hh:mm a").format(DateTime.now());
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: kPrimareColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubleFriendWidget extends StatelessWidget {
  ChatBubleFriendWidget({
    required this.message,
  });
  String date = DateFormat("hh:mm a").format(DateTime.now());
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: kBuleColorForAFreind,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.only(
            left: 8,
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
