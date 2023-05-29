import 'package:firstapp/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'mohamed abdelaal', phone: '01124043556'),
    UserModel(id: 2, name: 'ahmed', phone: '0112596347'),
    UserModel(id: 3, name: 'ziad', phone: '011249871204'),
    UserModel(id: 4, name: 'eslam ', phone: '011956556'),
    UserModel(id: 5, name: 'omar', phone: '0112448206'),
    UserModel(id: 1, name: 'mohamed abdelaal', phone: '01124043556'),
    UserModel(id: 2, name: 'ahmed', phone: '0112596347'),
    UserModel(id: 3, name: 'ziad', phone: '011249871204'),
    UserModel(id: 4, name: 'eslam ', phone: '011956556'),
    UserModel(id: 5, name: 'omar', phone: '0112448206'),
    UserModel(id: 1, name: 'mohamed abdelaal', phone: '01124043556'),
    UserModel(id: 2, name: 'ahmed', phone: '0112596347'),
    UserModel(id: 3, name: 'ziad', phone: '011249871204'),
    UserModel(id: 4, name: 'eslam ', phone: '011956556'),
    UserModel(id: 5, name: 'omar', phone: '0112448206'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users'
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context , index) => buildUsers(users[index]),
          separatorBuilder: (context , index) => Container(
            height: 1.0,
            color: Colors.grey,
          ),
          itemCount: users.length,
      ),
    );
  }
  Widget buildUsers(UserModel user) =>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          child: Text(
              '${user.id}',
            style: TextStyle(
              fontSize: 30,
            ),
          ),

        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
