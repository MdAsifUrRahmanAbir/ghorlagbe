import 'package:flutter/material.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.salePrice,
    required this.price,
    required this.textPrice,
    required this.isOnSale,
  }) : super(key: key);
  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnSale? salePrice : price;
    return Text(
      'TK${(price * int.parse(textPrice)).toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 15,
        color: color,
      ),
    );
  }
}
