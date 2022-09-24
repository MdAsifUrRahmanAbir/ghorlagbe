import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:demo/models/products_model.dart';
import 'package:demo/providers/cart_provider.dart';
import 'package:demo/widgets/price_widget.dart';
import 'package:demo/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../inner_screens/product_details.dart';
import '../providers/wishlist_provider.dart';
import '../services/utils.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    //final productModel1 = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(
              children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.32,
              width: size.width * 0.6,
              boxFit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextWidget(
                  text: productModel.title,
                  color: color,
                  maxLines: 1,
                  textSize: 15,
                  isTitle: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceWidget(
                    salePrice: productModel.salePrice,
                    price: productModel.price,
                    textPrice: _quantityTextController.text,
                    isOnSale: productModel.isOnSale,
                  ),
                  TextWidget(
                    text: productModel.productCategoryName,
                    color: Colors.redAccent,
                    textSize: 16,
                    isTitle: true,
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
