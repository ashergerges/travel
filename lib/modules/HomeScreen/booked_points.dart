import 'package:flutter/material.dart';
import 'package:travel/modules/HomeScreen/tab_screen.dart';
import 'package:travel/shared/Components.dart';
import 'package:travel/shared/Style.dart';

class BookedPoints extends StatelessWidget {
  const BookedPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            // Image(image:
            // AssetImage(
            //     'assets/images/background.png'
            // ),
            //   height: 900,
            //   fit: BoxFit.cover,
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done Successfuly',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                          color: ko),
                        ),
                        SizedBox(width: 5.0,),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ko,
                          child: Icon(Icons.check, color: Colors.purple, size: 20.0,),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      height: 300,
                      width: 300,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/896a4e414250d6674aab14bee5e48559.gif',
                            )
                          ),
                      ),
                    ),

                    defaultButton(
                      height: sizeFromHeight(context, 18),
                      width:  sizeFromWidth(context, 1.4),
                      background: ko,
                      border: mainColor,  function: () {
                     navigateAndFinish(context, const TabScreen());
                    },
                      text: 'Finish',  textColor: Colors.white,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
