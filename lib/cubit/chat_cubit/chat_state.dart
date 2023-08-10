import 'package:chatapp/model/message_model.dart';

abstract class ChatStates {}

class ChatInitState extends ChatStates {}

class ChatSuccessSendMessage extends ChatStates {
  List<MessageModel> messageList;

  ChatSuccessSendMessage({
    required this.messageList,
  });
}

class ChatDate extends ChatStates {}
