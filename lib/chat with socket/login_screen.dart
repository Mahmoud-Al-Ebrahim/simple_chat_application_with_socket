import 'package:chat_application_with_socket/chat%20with%20socket/chat_users_screen.dart';
import 'package:chat_application_with_socket/client%20side%20code/socket_utils.dart';
import 'package:chat_application_with_socket/global.dart';
import 'package:chat_application_with_socket/user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static String routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
   TextEditingController _usernameController=TextEditingController();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Global.initUsersList();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    widget._usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s Chat'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: widget._usernameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20)),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: (){
                if(widget._usernameController.text.isEmpty) {
                  return;
                }
                ClientSocket.socketRemoved();
                User me=Global.users[0];
                if(widget._usernameController.text.toLowerCase()=='b')
                {
                  me=Global.users[1];
                }
                else if(widget._usernameController.text.toLowerCase()=='c')
                {
                  me=Global.users[2];
                }
                Global.loginInUser=me;
                Navigator.of(context).pushReplacementNamed(ChatUsersScreen.routeName);
              },
              child: const Text('LOGIN',style: TextStyle(
                fontSize: 20
              ),),

            ),
          ],
        ),
      ),
    );
  }
}
