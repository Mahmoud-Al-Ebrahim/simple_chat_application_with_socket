import 'package:chat_application_with_socket/chat_message_model.dart';
import 'package:chat_application_with_socket/global.dart';
import 'package:chat_application_with_socket/messages%20bloc/chat_messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io; //instance from the library
import 'package:flutter_bloc/flutter_bloc.dart';


class ClientSocket {
  static io.Socket? socket; // object for the socket

  static connect(String serverUrl,BuildContext context){
    if(socket!=null)
      {
        socketRemoved();
      }
    socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
     socket!.connect();


      socket!.on("ReceiveMessage", (receivedMessage) {
         context.read<ChatMessagesCubit>().addToList(ChatMessageModel.fromJson(receivedMessage));
         context.read<ChatMessagesCubit>().chatMessagesChanged();
    });
    socket!.emit("signIn",Global.loginInUser.id);
  }
  static sendMessage(String message){
    socket!.emit("sendMessage",{
      "message":message,
      "from": Global.loginInUser.id,
      "to":Global.toChatScreen.id
    });
  }
  static socketRemoved(){
    if(socket!=null) {
      socket!.emit("removeSocket", Global.loginInUser.id);
      socket!.close();
      socket!.dispose();
      socket=null;
    }
  }
}
