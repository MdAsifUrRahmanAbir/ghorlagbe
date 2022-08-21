import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:demo/widgets/back_widget.dart';
import 'package:demo/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/orders_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    bool isEmpty = true;

    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'Your Ads',
            color: color,
            textSize: 24.0,
            isTitle: true,
          ),
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor
              .withOpacity(0.9),
        ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.width/2,
              child: isEmpty
               ? const EmptyScreen(
                  title: 'You didn\'t place any ads yet',
                  subtitle: 'Add ads and make me happy :)',
                  buttonText: 'Shop now',
                  imagePath: 'assets/images/cart.png',
                )
                :Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,),
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25)
        ),
        child: InkWell(
          onTap: () {
            //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_business_outlined, color: Colors.white, size: 100,),
                const SizedBox(
                  width: 8,
                ),
                TextWidget(
                    text: 'Post Ads', color: Colors.white, textSize: 18)
              ]
          ),
        ),
      ),

    );


    // return FutureBuilder(
    //     future: ordersProvider.fetchOrders(),
    //     builder: (context, snapshot) {
    //       return ordersList.isEmpty
    //           ? const EmptyScreen(
    //               title: 'You didnt place any order yet',
    //               subtitle: 'order something and make me happy :)',
    //               buttonText: 'Shop now',
    //               imagePath: 'assets/images/cart.png',
    //             )
    //           : Scaffold(
    //               appBar: AppBar(
    //                 leading: const BackWidget(),
    //                 elevation: 0,
    //                 centerTitle: false,
    //                 title: TextWidget(
    //                   text: 'Your Ads (${ordersList.length})',
    //                   color: color,
    //                   textSize: 24.0,
    //                   isTitle: true,
    //                 ),
    //                 backgroundColor: Theme.of(context)
    //                     .scaffoldBackgroundColor
    //                     .withOpacity(0.9),
    //               ),
    //               body: ListView.separated(
    //                 itemCount: ordersList.length,
    //                 itemBuilder: (ctx, index) {
    //                   return Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 2, vertical: 6),
    //                     child: ChangeNotifierProvider.value(
    //                       value: ordersList[index],
    //                       child: const OrderWidget(),
    //                     ),
    //                   );
    //                 },
    //                 separatorBuilder: (BuildContext context, int index) {
    //                   return Divider(
    //                     color: color,
    //                     thickness: 1,
    //                   );
    //                 },
    //               ));
    //     });
  }
}
