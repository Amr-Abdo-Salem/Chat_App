import 'package:chatapp/widgets/constans.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel(
    this.message,
    this.id,
  );

  factory MessageModel.fromJson(jasonData) {
    return MessageModel(jasonData[kMessage], jasonData['ID']);
  }
}
