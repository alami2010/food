/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
class ChatConversionModel {
  String? senderFirstName;
  int? senderId;
  String? receiverName;
  int? receiverId;
  String? senderLastName;
  String? senderCover;
  String? receiverLastName;
  String? receiverCover;
  int? senderType;
  int? receiverType;
  String? lastMessage;
  String? lastMessageType;
  String? updatedAt;

  ChatConversionModel(
      {this.senderFirstName,
      this.senderId,
      this.receiverName,
      this.receiverId,
      this.senderLastName,
      this.senderCover,
      this.receiverLastName,
      this.receiverCover,
      this.senderType,
      this.receiverType,
      this.lastMessage,
      this.lastMessageType,
      this.updatedAt});

  ChatConversionModel.fromJson(Map<String, dynamic> json) {
    senderFirstName = json['sender_first_name'];
    senderId = int.parse(json['sender_id'].toString());
    receiverName = json['receiver_name'];
    receiverId = int.parse(json['receiver_id'].toString());
    senderLastName = json['sender_last_name'];
    senderCover = json['sender_cover'];
    receiverLastName = json['receiver_last_name'];
    receiverCover = json['receiver_cover'];
    senderType = int.parse(json['sender_type'].toString());
    receiverType = int.parse(json['receiver_type'].toString());
    lastMessage = json['last_message'];
    lastMessageType = json['last_message_type'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_first_name'] = senderFirstName;
    data['sender_id'] = senderId;
    data['receiver_name'] = receiverName;
    data['receiver_id'] = receiverId;
    data['sender_last_name'] = senderLastName;
    data['sender_cover'] = senderCover;
    data['receiver_last_name'] = receiverLastName;
    data['receiver_cover'] = receiverCover;
    data['sender_type'] = senderType;
    data['receiver_type'] = receiverType;
    data['last_message'] = lastMessage;
    data['last_message_type'] = lastMessageType;
    data['updated_at'] = updatedAt;
    return data;
  }
}
