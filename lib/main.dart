import 'package:chat_application_with_socket/messages%20bloc/chat_messages_cubit.dart';
import 'package:chat_application_with_socket/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatMessagesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routes(),
        initialRoute: Routes.initScreen(),
      ),
    );
  }
}
