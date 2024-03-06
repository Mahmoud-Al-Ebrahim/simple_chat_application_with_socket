import 'package:chat_application_with_socket/chat%20with%20socket/chat_title.dart';
import 'package:chat_application_with_socket/client%20side%20code/socket_utils.dart';
import 'package:chat_application_with_socket/global.dart';
import 'package:chat_application_with_socket/messages%20bloc/chat_messages_cubit.dart';
import '../chat_message_model.dart';
import '../messages bloc/chat_messages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String routeName = '/chat_screen';


  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  final UserOnlineStatus _userOnlineStatus = UserOnlineStatus.connection;

  @override
  void initState() {
    // TODO: implement initState
    context.read<ChatMessagesCubit>().chatMessagesChanged();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          toChatUser: Global.toChatScreen,
          userStatus: _userOnlineStatus,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: BlocBuilder<ChatMessagesCubit, ChatMessagesChanged>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: state.chatMessages[index].from ==
                              Global.loginInUser.id
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: state.chatMessages[index].from ==
                                Global.loginInUser.id
                            ? 0
                            : 4,
                        shadowColor: Colors.black,
                        color: state.chatMessages[index].from ==
                                Global.loginInUser.id
                            ? Colors.blue
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            state.chatMessages[index].message,
                            style: TextStyle(
                              fontSize: 15,
                              color: (state.chatMessages[index].from ==
                                      Global.loginInUser.id)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.chatMessages.length,
                );
              },
            )),
            typeMessageSection(context),
          ],
        ),
      ),
    );
  }

  Widget typeMessageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Type Message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                  ClientSocket.sendMessage(_messageController.text);
                  context.read<ChatMessagesCubit>().addToList(ChatMessageModel.fromJson({
                    "message":_messageController.text,
                    "from": Global.loginInUser.id,
                    "to":Global.toChatScreen.id
                  }));
                  context.read<ChatMessagesCubit>().chatMessagesChanged();
                  _messageController.clear();
              }
            },
          )
        ],
      ),
    );
  }
}
