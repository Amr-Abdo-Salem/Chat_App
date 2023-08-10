import 'package:chatapp/cubit/chat_cubit/chat_state.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:chatapp/widgets/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitState());
  String? date;
  List<MessageModel> messagesList = [];
  MessageModel? messageModel;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  void sendMessage({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kCreatedAt: DateTime.now(),
      'ID': email,
    });
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccessSendMessage(
        messageList: messagesList,
      ));
    });
  }

  getDate() {
    return date = DateFormat("hh:mm a").format(DateTime.now());
  }
}
