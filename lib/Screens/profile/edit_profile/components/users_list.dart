import 'package:flutter/material.dart';
import 'package:flutter_eft/Screens/models/users.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Users user;
  @override
  Widget build(BuildContext context) {
    // final users = Provider.of<Users>(context);
    List<Users> userResults = [];
    
    // print(users);
    // return Container();
    // users.forEach((brew) {
    //   print(brew.firstName);
    //   print(brew.lastName);
    //   print(brew.age);
    //   print(brew.email);
    //   print(brew.password);
    //   print(brew.photoUrl);
    // });
    // return ListView.builder(
    //   itemCount: users.length,
    //   itemBuilder: (context, index) => {
    //     return UserTile(user: users[index]);
    //   },
    // );
  }
}
