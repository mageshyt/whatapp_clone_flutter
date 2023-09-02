import 'package:flutter/material.dart';

class UserInformationView extends StatefulWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  _UserInformationViewState createState() => _UserInformationViewState();
}

class _UserInformationViewState extends State<UserInformationView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('User Profile Page'),
      ),
    );
  }
}
