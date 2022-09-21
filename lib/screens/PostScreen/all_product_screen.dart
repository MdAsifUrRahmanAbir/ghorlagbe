import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/products_model.dart';
import '../../providers/products_provider.dart';


class AllProductList extends StatelessWidget {
  const AllProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authEmail = FirebaseAuth.instance.currentUser?.email;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsByUser = productProviders.getUserProducts(authEmail!);

    return  SafeArea(child: Scaffold(
        appBar: AppBar(
          title: const Text("Your Ads", style: TextStyle(color: Colors.red),),
        ),
      body: ListView.builder(
        itemCount: productsByUser.length,
          itemBuilder: (_, index){
          var data = productsByUser[index];
            return Text(data.authEmail);
          }
      )
    ));
  }
}


/*
GlobalMethods.warningDialog(
                                      title: 'Delete?',
                                      subtitle: 'Press okay to confirm',

                                      fct: () async {
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(widget.id)
                                            .delete();
                                        await Fluttertoast.showToast(
                                          msg: "Product has been deleted",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                        );
                                        while (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                      },

                                      context: context
                                  );// glo
 */
