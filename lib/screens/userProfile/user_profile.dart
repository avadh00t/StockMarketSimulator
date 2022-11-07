import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/mainPage/mainPageBackground/main_page_background.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(builder: (context) => MainPageBackground()));
          },
        ),
      ),
    );
  }
}
