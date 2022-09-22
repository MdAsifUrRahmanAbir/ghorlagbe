import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../models/products_model.dart';
import '../../providers/products_provider.dart';
import '../../services/global_methods.dart';


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
            return Card(
              child: ExpansionTile(
                leading: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(data.imageUrl)),
                title: Text(data.title),
                subtitle: Text(data.productCategoryName,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5
                ),

                childrenPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10
                ),

                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                children: [
                  Text(
                    "ID: ${data.id}",
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Price: ${data.price}",textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Phone No: ${data.call}",textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Description: ${data.description}",textAlign: TextAlign.left,
                  ),
                ],

                trailing: TextButton.icon(
                    onPressed: (){
                      GlobalMethods.warningDialog(
                          title: 'Delete?',
                          subtitle: 'Press okay to confirm',

                          fct: () async {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(data.id)
                                .delete();
                            final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
                            productsProvider.fetchProducts();
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
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text('Delete',
                      style: TextStyle(color: Colors.red),
                    )
                ),
              ),
            );
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
