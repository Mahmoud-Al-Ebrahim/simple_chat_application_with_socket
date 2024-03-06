import 'package:chat_application_with_socket/user.dart';

class Global {
  static late List<User> users;
  static late User loginInUser;
  static late User toChatScreen;

  static initUsersList() {
    users = [];
    User userA = User(id: 1000, name: "A", email: "testa@gmail.com");
    User userB = User(id: 1001, name: "B", email: "testb@gmail.com");
    User userC = User(id: 1002, name: "C", email: "testc@gmail.com");
    User userGroup = User(id: 1004, name: "Group", email: "testabc@gmail.com");

    users.add(userA);
    users.add(userB);
    users.add(userC);
    users.add(userGroup);
  }

  static getUserFor(User user) {
    List<User> filteredUsers = users
        .where((u) => !(u.name.toLowerCase().contains(user.name.toLowerCase())))
        .toList();
    return filteredUsers;
  }

}
