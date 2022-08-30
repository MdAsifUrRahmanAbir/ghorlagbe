import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:demo/widgets/heart_btn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../consts/firebase_consts.dart';
import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../providers/viewed_prod_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import '../widgets/text_widget.dart';
import 'check_out.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  //final String map;
  /*final String id, title, price, productCat, imageUrl, description,map,mapUrl;
  final bool isPiece, isOnSale;
  final double salePrice;*/

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }





  //new added part
  /*Future _mapurlLancher() async {
    if (!await (launch(mapUrl))) throw 'Could not find ${widget.mapUrl}';
  }*/
//new added part





  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(productId);

    double usedPrice = getCurrProduct.price;


    //new added part
    String mapUrl = getCurrProduct.map;
    //new added part
    Future _mapurlLancher() async {
      if (!await (launch(mapUrl))) throw 'Could not find ${mapUrl}';
    }
//new added part
    //new added part


    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrProduct.id);

    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        viewedProdProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () =>
                  Navigator.canPop(context) ? Navigator.pop(context) : null,
              child: Icon(
                IconlyLight.arrowLeft2,
                color: color,
                size: 24,
              ),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Column(children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrProduct.imageUrl,
              boxFit: BoxFit.fill,
              //width: size.width,
              // height: screenHeight * .4,
              width: double.infinity,
              height: 300,
            ),
          ),


          SizedBox(height: 5,),

          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: getCurrProduct.title,
                            color: color,
                            textSize: 25,
                            isTitle: true,
                          ),
                        ),
                        HeartBTN(
                          productId: getCurrProduct.id,
                          isInWishlist: _isInWishlist,
                        )
                      ],
                    ),
                  ),




                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Container(

                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white
                      ),
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(getCurrProduct.description,style: TextStyle(color: Colors.black),),
                        ),

                        /*TextWidget(
                          text: getCurrProduct.description,
                          color: Colors.black,
                          textSize: 18,
                          isTitle: true,
                        ),*/
                      ),
                    ),
                  ),


                  SizedBox(height: 8,),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'TK${usedPrice.toString()}',
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: getCurrProduct.isPiece ? '/For Sell' : '/For Rent',
                          color: color,
                          textSize: 12,
                          isTitle: false,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(63, 200, 101, 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextWidget(
                            text: 'TRUSTED SITE',
                            color: Colors.white,
                            textSize: 20,
                            isTitle: true,
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(
                    height: 6,
                  ),
                  getCurrProduct.isPiece?Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      quantityControl(
                        fct: () {
                          if (_quantityTextController.text == '1') {
                            return;
                          } else {
                            setState(() {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        icon: CupertinoIcons.minus,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _quantityTextController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityTextController.text = '1';
                              } else {}
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      quantityControl(
                        fct: () {
                          setState(() {
                            _quantityTextController.text =
                                (int.parse(_quantityTextController.text) + 1)
                                    .toString();
                          });
                        },
                        icon: CupertinoIcons.plus,
                        color: Colors.green,
                      ),
                    ],
                  ),








                  //SizedBox(height: 2,),
                  //new added part
                  InkWell(
                    onTap: (){
                      setState(() {
                        _mapurlLancher();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                      child: Card(
                        color: Colors.blue,
                        child: ListTile(
                          //leading: Icon(Icons.location_pin),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_pin),
                              SizedBox(width: 10,),
                              Text("Directions"),
                            ],
                          ),
                          //trailing: FaIcon(FontAwesomeIcons.handPointer,color: Colors.amber,),
                        ),
                      ),
                    ),
                  ),
                  //new added part










                  //const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: getCurrProduct.isPiece?'Total':'Advance for 1 month Min',
                                color: Colors.red.shade300,
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      text:
                                          'TK${totalPrice.toStringAsFixed(2)}',
                                      color: color,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text: getCurrProduct.isPiece?"":'/${_quantityTextController.text}Months',
                                      color: color,
                                      textSize: 16,
                                      isTitle: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: ()async{
                                final User? user =
                                    authInstance.currentUser;

                                if (user == null) {
                                  GlobalMethods.errorDialog(
                                      subtitle:
                                      'No user found, Please login first',
                                      context: context);
                                  return;
                                }



                                ///
                                //User? user = authInstance.currentUser;
                                /*final orderId = const Uuid().v4();
                                final productProvider =
                                Provider.of<ProductsProvider>(context, listen: false);

                                cartProvider.getCartItems.forEach((key, value) async {
                                  final getCurrProduct = productProvider.findProdById(
                                    value.productId,
                                  );
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(orderId)
                                        .set({
                                      'orderId': orderId,
                                      'userId': user!.uid,
                                      'productId': value.productId,
                                      'price': (getCurrProduct.isOnSale
                                          ? getCurrProduct.salePrice
                                          : getCurrProduct.price) *
                                          value.quantity,
                                      'totalPrice': total,
                                      'quantity': value.quantity,
                                      'imageUrl': getCurrProduct.imageUrl,
                                      'userName': user.displayName,
                                      'orderDate': Timestamp.now(),
                                    });
                                    await cartProvider.clearOnlineCart();
                                    cartProvider.clearLocalCart();
                                    ordersProvider.fetchOrders();
                                    await Fluttertoast.showToast(
                                      msg: "Your order has been placed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } catch (error) {
                                    GlobalMethods.errorDialog(
                                        subtitle: error.toString(), context: ctx);
                                  } finally {}
                                });*/
                                /////





                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CheckOutScreen()));

                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  //getCurrProduct.isPiece?Container():
                                  child: TextWidget(
                                      text:
                                      getCurrProduct.isPiece? 'BUY' : 'GET RENT',
                                      color: Colors.white,
                                      textSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
