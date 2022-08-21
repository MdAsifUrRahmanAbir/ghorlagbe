import 'package:flutter/material.dart';

import '../../inner_screens/drawer_screen.dart';

class AllOrderList extends StatelessWidget {
  const AllOrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(),
      drawer: const DrawerScreen(),
      body: Center(
        child: Text('All Request List Page'),
      ),
    ));
  }
}
