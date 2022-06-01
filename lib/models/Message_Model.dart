class MessageModel
{
  String? senderId;
  String? receviverId;
  String? dateTime;
  String? text;



  MessageModel({
    required this.senderId,
    required this.receviverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromjson(Map<String ,dynamic>json)
  {
    senderId =json['senderId'];
    receviverId= json['receverId'];
    dateTime = json ['dataTime'];
    text = json ['text'];
  }

  Map<String,dynamic>toMap()
  {
    return
      {
        'senderId':senderId,
        'receviverId':receviverId,
        'dateTime':dateTime,
        'senderId':senderId,
        'text':text
      };
  }
}