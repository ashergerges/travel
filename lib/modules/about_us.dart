import 'package:flutter/material.dart';
import 'package:travel/shared/Style.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
       centerTitle: true,
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AboutUS(
                    context: context,
                      name: 'Beshoy Wageh',
                      assets:
                          'assets/images/besho1.jpg'),
                  AboutUS(
                      context: context,
                      name: 'Beshoy Reda',
                      assets:
                          'assets/images/besho2.jpg'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [

                  AboutUS(
                      context: context,
                      name: 'David Mody',
                      assets:
                          'assets/images/david.jpg'),
                  AboutUS(
                      context: context,
                      name: 'Mariam Botros',
                      assets:
                          'assets/images/mariam.jpg'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Our Value',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OurValue(icon: Icons.check,name: ' Team members are diverse',context: context),
              SizedBox(
                height: 20,
              ),
              OurValue(icon: Icons.handshake,name: ' We communicate well with each other',context: context),
              SizedBox(
                height: 20,
              ),
              OurValue(icon: Icons.align_horizontal_right_rounded,name: ' We focus on goals and results',context: context),
              SizedBox(
                height: 20,
              ),
              OurValue(icon:Icons.text_snippet_outlined ,name: ' We are organized',context: context),
              SizedBox(
                height: 20,
              ),
              OurValue(icon: Icons.add_reaction_outlined,name: ' We have fun',context: context),
              SizedBox(
                height:100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget AboutUS({
    required String name,
    required String assets,
    required BuildContext context,
  }) =>
      Padding(
        padding:  EdgeInsets.only(right: sizeFromWidth(context, 23),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: sizeFromHeight(context, 6),
                  width: sizeFromWidth(context, 3),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[200],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(bottom: 5, start: 10),
                  child: Container(
                    height:sizeFromHeight(context, 6),
                    width: sizeFromWidth(context, 2.9),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Image(
                        image: AssetImage(assets,),fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      );
  Widget OurValue({
    required String name,
    required IconData icon,
    required BuildContext context,

  }) =>   Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: Row(

      children: [

        Icon(icon),
        Text(name,
          style:  TextStyle(
              fontSize: sizeFromWidth(context, 25.8),
              fontWeight: FontWeight.w900
          ),
        ),

      ],
    ),
  );


}
