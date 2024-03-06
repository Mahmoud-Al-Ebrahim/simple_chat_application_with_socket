import 'package:chat_application_with_socket/user.dart';
import 'package:flutter/material.dart';

enum UserOnlineStatus {
  connection,
  online,
  notOnline,
}

class ChatTitle extends StatelessWidget {
  const ChatTitle(
      {Key? key, required this.toChatUser, required this.userStatus})
      : super(key: key);

  final User toChatUser;
  final UserOnlineStatus userStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(toChatUser.name),
        Text(getUserStatus(),style:const TextStyle(
          fontSize: 14,
          color: Colors.white70,

        ),),
      ],
    );
  }
  getUserStatus(){
    if(userStatus==UserOnlineStatus.online)
      {
        return 'online';
      }
    else if(userStatus==UserOnlineStatus.notOnline)
    {
      return 'offline';
    }
    else if(userStatus==UserOnlineStatus.connection)
    {
      return 'connection';
    }
  }
}
