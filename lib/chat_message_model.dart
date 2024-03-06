class ChatMessageModel {
  int to;
  int from;
  String message;
  ChatMessageModel(
      {
        required this.to,
        required this.from,
        required this.message,
      });
   factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
     return ChatMessageModel(
    to : json['to'] as int,
    from : json['from'] as int,
    message : json['message'] as String,
     );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['to'] = to;
    data['from'] =from;
    data['message'] = message;
    return data;
  }
}