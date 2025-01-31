
import 'package:flutter/material.dart';
import 'package:hollat/login/data/sharedpreferences/save_token.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String value = '';

  void startNavigationByTimer() async {
    final token = await getToken();
    if(token != null){
      setState(() {
        value = token;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text('Prfile Page: ${value}'),
    );
  }
}
