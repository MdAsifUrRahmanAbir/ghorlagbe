import 'package:demo/screens/PostScreen/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';


import '../providers/dark_theme_provider.dart';
import '../screens/PostScreen/all_order_screen.dart';
import '../screens/PostScreen/main_page.dart';
import '../screens/wishlist/drawer_tile.dart';
import '../services/utils.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    // final theme = Utils(context).getTheme;
    // final themeState = Provider.of<DarkThemeProvider>(context);
    // final color = Utils(context).color;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/ghor-chai-logo.png",
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          DrawerListTile(
            title: "Post",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            },
            icon: IconlyBold.paper_upload,
          ),
          DrawerListTile(
            title: "Ads",
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllProductList()));
            },
            icon: IconlyBold.scan,
          ),
        ],
      ),
    );
  }
}
