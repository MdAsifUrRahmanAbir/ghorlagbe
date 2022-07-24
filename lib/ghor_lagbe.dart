import 'package:flutter/material.dart';
import 'package:ghorlagbe/screens/btm_bar.dart';
import 'package:ghorlagbe/widgets/text_widget.dart';

class Ghorlagbe extends StatelessWidget {
  const Ghorlagbe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Image.asset('assets/images/ghor-chai-logo.png', height: 100, width: double.infinity, fit: BoxFit.contain,),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25)
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  const BottomBarScreen()));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.find_replace_outlined, color: Colors.white, size: 100,),
                      const SizedBox(
                        width: 8,
                      ),
                      TextWidget(
                          text: 'Find Home', color: Colors.white, textSize: 18)
                    ]
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: InkWell(
                onTap: () {

                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_business_outlined, color: Colors.white, size: 100,),
                      const SizedBox(
                        width: 8,
                      ),
                      TextWidget(
                          text: 'Post Home', color: Colors.white, textSize: 18)
                    ]
                ),
              ),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
