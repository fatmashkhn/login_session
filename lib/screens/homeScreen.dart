import 'package:flutter/material.dart';
import 'package:login_session_app/screens/loginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Text("Welcome users"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use Navigator.of(context) to navigate back to the login screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
