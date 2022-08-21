import 'package:demo/inner_screens/drawer_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(),
      drawer: const DrawerScreen(),
      body: Center(
        child: Text('Main Page'),
      ),
    ));
  }
}
