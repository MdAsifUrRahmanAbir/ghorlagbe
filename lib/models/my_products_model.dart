import 'package:flutter/cupertino.dart';

class MyProductModel with ChangeNotifier{
  final String id, title, description,map,call, imageUrl, productCategoryName;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  MyProductModel(
      {required this.id,
      required this.title,
      required this.description,
        required this.map,
        required this.call,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});
}
