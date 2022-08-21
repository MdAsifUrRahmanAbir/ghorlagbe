import 'package:flutter/material.dart';

import '../../inner_screens/drawer_screen.dart';

class AllProductList extends StatelessWidget {
  const AllProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
        appBar: AppBar(),
      drawer: DrawerScreen(),
      body: Center(
        child: Text('My All Ads Page'),
      ),
    ));
  }
}
