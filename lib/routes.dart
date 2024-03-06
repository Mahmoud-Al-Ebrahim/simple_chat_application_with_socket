
import 'package:chat_application_with_socket/chat%20with%20socket/chat_screen.dart';
import 'package:chat_application_with_socket/chat%20with%20socket/chat_users_screen.dart';
import 'package:chat_application_with_socket/chat%20with%20socket/login_screen.dart';
import 'package:chat_application_with_socket/chat_message_model.dart';

class Routes{

  static routes()
  {
    return {
      LoginScreen.routeName:(context)=>LoginScreen(),
      ChatUsersScreen.routeName:(context)=>ChatUsersScreen(),
      ChatScreen.routeName:(context)=>ChatScreen(),
    };

  }
  static initScreen()
  {
    return LoginScreen.routeName;
  }

}