import 'package:meta/meta.dart';

@immutable
class MessageData {
 const MessageData(
      {required this.senderName,
      required this.message,
      required this.messageDate,
      required this.datemessage,
      required this.profilePic});

  final String senderName;
  final String message;
  final DateTime messageDate;
  final String datemessage;
  final String profilePic;


}
