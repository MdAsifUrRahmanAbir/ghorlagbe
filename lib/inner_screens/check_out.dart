import 'dart:async';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import '../screens/btm_bar.dart';

//ignore: must_be_immutable
class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);


  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  //CartController controller=Get.put(CartController());
  double h=0.0;
  double w=0.0;

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController  controllerGlobal;
  // var baseUrl = 'https://sandbox.sslcommerz.com/EasyCheckOut/testcdee41ffc880ccc469e0cae80428a656f58';
  var baseUrl = 'https://sandbox.sslcommerz.com/EasyCheckOut/testcdedd999ea3eb0dc35aa9350e0395941508';
  // var baseUrl = 'https://dummypay.publicdemo.xyz/';
  bool isLoading = true;

  @override
  void initState() {
    if(Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop:()=>_exitApp(context),
          child: Stack(
            children: [
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: baseUrl,

                userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                gestureNavigationEnabled: true,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.future.then((value) => controllerGlobal = value);
                  _controller.complete(webViewController);
                },

                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  setState(() {
                    isLoading = true;
                    if(url == 'https://dummypay.publicdemo.xyz/index.php?success=true') {
                      isLoading = false;
                      showSnackBar('Payment Success');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                    }else if(url == 'https://dummypay.publicdemo.xyz/index.php?cancel=true') {
                      showSnackBar('Payment Canceled');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                    }else if(url == 'https://dummypay.publicdemo.xyz/index.php?cancel=true') {
                      showSnackBar('Payment Canceled');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                    }
                  });

                  bool _isSuccess = url.contains('success') && url.contains(baseUrl);
                  bool _isFailed = url.contains('fail') && url.contains(baseUrl);
                  bool _isCancel = url.contains('cancel') && url.contains(baseUrl);

                  if(_isSuccess) {
                    showSnackBar('Payment Success');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }else if(_isFailed) {
                    showSnackBar('Payment Failed');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }else if(_isCancel) {
                    showSnackBar('Payment Canceled');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }
                },

                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    isLoading = false;
                    if(url == 'https://dummypay.publicdemo.xyz/index.php?success=true') {
                      showSnackBar('Payment Success');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                    }else if (url == 'https://sandbox.sslcommerz.com/gwprocess/v4/warning.php'){
                      isLoading = false;
                      showSnackBar('Payment Success');
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                      // https://sandbox.sslcommerz.com/gwprocess/v4/warning.php
                    }
                  });
                },
              ),

              isLoading ? Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),));
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}


/*
Stack(
            children: [
              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: baseUrl,
                userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                gestureNavigationEnabled: true,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.future.then((value) => controllerGlobal = value);
                  _controller.complete(webViewController);
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  setState(() {
                    isLoading = true;
                  });
                  bool _isSuccess = url.contains('success') && url.contains(baseUrl);
                  bool _isFailed = url.contains('fail') && url.contains(baseUrl);
                  bool _isCancel = url.contains('cancel') && url.contains(baseUrl);
                  if(_isSuccess) {
                    showSnackBar('Payment Success');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }else if(_isFailed) {
                    showSnackBar('Payment Failed');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }else if(_isCancel) {
                    showSnackBar('Payment Canceled');
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
                  }
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading ? Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
              ) : const SizedBox.shrink(),
            ],
          )
 */


