import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, description,map, imageUrl, productCategoryName;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
        required this.map,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});
}
