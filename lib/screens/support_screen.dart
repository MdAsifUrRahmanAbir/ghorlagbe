import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  final String call = '+8801856199643';
  final String email = '+mdjishanulfahim@gmail.com';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _bodyWidget(context),
    );
  }

  /*
  mdjishanulfahim@gmail.com

  +8801856199643
   */

  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Align(
            alignment: Alignment.center,
            child: Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20
              ),

              shadowColor: Colors.white,
              elevation: 2,
              borderOnForeground: true,
              semanticContainer: true,
              color: Colors.white,
              surfaceTintColor: Colors.blue,

              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(45),
                    )
                  ),
                  child: const Text(
                      'Contact Us For Make your Post In Top Wanted',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.purple,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.clip,
                    ),
                    overflow: TextOverflow.clip,
                    softWrap: true,
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                  )
              ),
            )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  alignment: Alignment.center,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellowAccent.withOpacity(0.2),
                  ),

                  child:  const Text(
                    'Contact By Call'
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20
                  ),
                  alignment: Alignment.center,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.yellowAccent.withOpacity(0.2),
                  ),

                  child:  const Text(
                      'Contact By Email'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(
                  call
                ),
                 Text(
                    email
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      launch('tel:$call');
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),

                    child: const Icon(Icons.call,color: Colors.white,),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      launch('mailto:$email');
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue,
                    ),

                    child: const Icon(Icons.email,color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
