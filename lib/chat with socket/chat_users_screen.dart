import 'package:chat_application_with_socket/chat%20with%20socket/chat_screen.dart';
import 'package:chat_application_with_socket/chat%20with%20socket/login_screen.dart';
import 'package:chat_application_with_socket/client%20side%20code/socket_utils.dart';
import 'package:chat_application_with_socket/global.dart';
import 'package:chat_application_with_socket/user.dart';
import 'package:flutter/material.dart';
class ChatUsersScreen extends StatefulWidget {
 const ChatUsersScreen({Key? key}) : super(key: key);
  static String routeName = '/chat_users_screen';

  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  late List<User> chatUsers;

  @override
  void initState() {
    ClientSocket.connect("http://192.168.43.169:5000", context);
    chatUsers = Global.getUserFor(Global.loginInUser);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s Chat'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            }, icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(child: ListView.builder(itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Global.toChatScreen=chatUsers[index];
                      Navigator.pushNamed(context, ChatScreen.routeName);
                    },
                    child: ListTile(
                      title: Text(chatUsers[index].name),
                      subtitle: Text(
                          'ID ${chatUsers[index].id}, Email: ${chatUsers[index].email}'),
                    ),
                  );
                },
                itemCount: chatUsers.length,
                ))
              ],
            )));
  }
}
