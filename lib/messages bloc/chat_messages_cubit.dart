
import 'package:flutter_bloc/flutter_bloc.dart';
import '../chat_message_model.dart';
import '../global.dart';
import '../messages bloc/chat_messages_state.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class ChatMessagesCubit extends Cubit<ChatMessagesChanged> {
  ChatMessagesCubit() : super(ChatMessagesChanged([]));

    late List<ChatMessageModel> chatMessages;
  void chatMessagesChanged() async{
    List<ChatMessageModel> list= await getMessages();
    emit(ChatMessagesChanged(list));
  }
   getMessages()async{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      var data=prefs.getStringList('chatMessages');
      if(data==null) {
        chatMessages = [];
        prefs.setStringList('chatMessages',[]);
      }
      else {
        if(data.isEmpty)
        {
          chatMessages=[];
        }
        else{
          chatMessages=[];
          chatMessages= List<ChatMessageModel>.from(data.map((message)=>ChatMessageModel.fromJson(json.decode(message))));
        }
      }
      if(chatMessages.isNotEmpty) {
      return chatMessages.where((message) =>
      (message.from == Global.loginInUser.id &&
          message.to == Global.toChatScreen.id) ||
          (message.from == Global.toChatScreen.id &&
              message.to == Global.loginInUser.id)
      ).toList();
    }
    else {return <ChatMessageModel>[];}
  }
  void addToList(value)async
  {
    chatMessages.add(value);
     uploadDataToShared();
  }

  void uploadDataToShared()async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    if(chatMessages.isEmpty) {
      prefs.setStringList('chatMessages', []);
    }
    else{
      prefs.setStringList('chatMessages', chatMessages.map((favorite) =>(json.encode(favorite.toJson()))).toList());
    }
  }
}
