import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/Book%20Model.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/shared/Components.dart';

import '../../shared/Style.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getProfile()..bookUsers()..bookSystem(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  ConditionalBuilder(
            // condition: true,
            condition: FirebaseAuth.instance.currentUser!.uid.toString()!=systemId,
            builder: (context) => Scaffold(
              backgroundColor: Colors.grey[100],
              body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                          // condition: true,
                          condition: AuthenticationCubit.get(context).phone!='',
                          builder: (context) =>  Column(
                            children: [
                              Container(
                                width: sizeFromWidth(context, 1),
                                margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.03),
                                        spreadRadius: 10,
                                        blurRadius: 3,
                                        // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 25, right: 20, left: 20),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Stack(
                                            alignment: AlignmentDirectional.bottomEnd,
                                            children: [
                                              AuthenticationCubit.get(context).postImage!=null? Container(
                                                width: 100,
                                                height: 100,
                                                decoration:  BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: FileImage(AuthenticationCubit.get(context).postImage!),
                                                        fit: BoxFit.cover)
                                                ),
                                              ) :
                                              Container(
                                                width: 200,
                                                height: 200,
                                                decoration:  BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(AuthenticationCubit.get(context).image),
                                                        fit: BoxFit.cover)
                                                ),
                                              ),
                                              // IconButton(
                                              //   onPressed: (){
                                              //     // Navigator.push(
                                              //     //     context,
                                              //     //     MaterialPageRoute(builder: (context) => const UpdateProfile()));
                                              //   },
                                              //   icon: Container(
                                              //     height: 50,
                                              //     width: 50,
                                              //     decoration:  BoxDecoration(
                                              //       shape: BoxShape.circle,
                                              //       color: Colors.blueGrey,
                                              //     ),
                                              //     child: const Icon(Icons.edit, color: Colors.white,),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 40) * 0.6,
                                            child:  Center(
                                              child: Text(
                                                AuthenticationCubit.get(context).name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text("Details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.blueGrey,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children:  [
                                          Icon(Icons.email),
                                          SizedBox(width: 5,),
                                          Text(
                                            AuthenticationCubit.get(context).email,
                                            style:TextStyle(
                                                color: backgroundColorDark,
                                                fontSize: sizeFromHeight(context, 55),
                                                fontWeight: FontWeight.w900),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        children:  [
                                          Icon(Icons.phone_android),
                                          SizedBox(width: 5,),
                                          Text(
                                            AuthenticationCubit.get(context).phone,
                                            style:TextStyle(
                                                color: backgroundColorDark,
                                                fontSize: sizeFromHeight(context, 55),
                                                fontWeight: FontWeight.w900),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                          fallback: (context) => Column(
                              children: [
                                Container(
                                  width: sizeFromWidth(context, 1),
                                  margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.03),
                                          spreadRadius: 10,
                                          blurRadius: 3,
                                          // changes position of shadow
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 25, right: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Stack(
                                              alignment: AlignmentDirectional.bottomEnd,
                                              children: [
                                                AuthenticationCubit.get(context).postImage!=null? Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration:  BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: FileImage(AuthenticationCubit.get(context).postImage!),
                                                          fit: BoxFit.cover)
                                                  ),
                                                ) :
                                                Container(
                                                  width: 200,
                                                  height: 200,
                                                  decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://th.bing.com/th/id/R.4b38b1945e88a36e2308debb1c766e94?rik=15AY1JjLsPP5PQ&pid=ImgRaw&r=0"),
                                                          fit: BoxFit.cover)
                                                  ),
                                                ),
                                                // IconButton(
                                                //   onPressed: (){
                                                //     // Navigator.push(
                                                //     //     context,
                                                //     //     MaterialPageRoute(builder: (context) => const UpdateProfile()));
                                                //   },
                                                //   icon: Container(
                                                //     height: 50,
                                                //     width: 50,
                                                //     decoration:  BoxDecoration(
                                                //       shape: BoxShape.circle,
                                                //       color: Colors.blueGrey,
                                                //     ),
                                                //     child: const Icon(Icons.edit, color: Colors.white,),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width - 40) * 0.6,
                                              child:  Center(
                                                child: Text(
                                                  "User Name",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                          ],
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25, right: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text("Details",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.blueGrey,
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children:  [
                                            Icon(Icons.email),
                                            SizedBox(width: 5,),
                                            Text(
                                              '**************@gmail.com',
                                              style:TextStyle(
                                                  color: backgroundColorDark,
                                                  fontSize: sizeFromHeight(context, 55),
                                                  fontWeight: FontWeight.w900),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          children:  [
                                            Icon(Icons.phone_android),
                                            SizedBox(width: 5,),
                                            Text(
                                              '01************',
                                              style:TextStyle(
                                                  color: backgroundColorDark,
                                                  fontSize: sizeFromHeight(context, 55),
                                                  fontWeight: FontWeight.w900),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              Text("Booking",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueGrey,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            ConditionalBuilder(
                                condition: AuthenticationCubit.get(context).bookingUser.isNotEmpty,
                                //  condition:true,
                                builder: (context) => Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => buildBookingItem(
                                          AuthenticationCubit.get(context).bookingUser[index],
                                          context,
                                          index),
                                      itemCount:  AuthenticationCubit.get(context).bookingUser.length,
                                      // itemCount:  15,
                                    ),
                                  ],
                                ),
                                fallback: (context) => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Center(),
                                  ),
                                )
                            ),


                          ],
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          // height: sizeFromHeight(context, 3.8),
                          width: sizeFromWidth(context, 1.5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              AuthenticationCubit.get(context).logout(context);
                            },
                            child: const Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  )),
            ),
            fallback: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: sizeFromWidth(context, 1),
                    margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.03),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 25, right: 20, left: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  AuthenticationCubit.get(context).postImage!=null? Container(
                                    width: 100,
                                    height: 100,
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(AuthenticationCubit.get(context).postImage!),
                                            fit: BoxFit.cover)
                                    ),
                                  ) :
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://th.bing.com/th/id/R.4b38b1945e88a36e2308debb1c766e94?rik=15AY1JjLsPP5PQ&pid=ImgRaw&r=0"),
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: (){
                                  //     // Navigator.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(builder: (context) => const UpdateProfile()));
                                  //   },
                                  //   icon: Container(
                                  //     height: 50,
                                  //     width: 50,
                                  //     decoration:  BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: Colors.blueGrey,
                                  //     ),
                                  //     child: const Icon(Icons.edit, color: Colors.white,),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: (MediaQuery.of(context).size.width - 40) * 0.6,
                                child:  Center(
                                  child: Text(
                                    "System",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children:  [
                              Icon(Icons.email),
                              SizedBox(width: 5,),
                              Text(
                                'System@gmail.com',
                                style:TextStyle(
                                    color: backgroundColorDark,
                                    fontSize: sizeFromHeight(context, 55),
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children:  [
                              Icon(Icons.phone_android),
                              SizedBox(width: 5,),
                              Text(
                                '01221167185',
                                style:TextStyle(
                                    color: backgroundColorDark,
                                    fontSize: sizeFromHeight(context, 55),
                                    fontWeight: FontWeight.w900),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                     condition: AuthenticationCubit.get(context).bookingSystem.isNotEmpty,

                      builder: (context) => Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildBookingItemSystem(
                                AuthenticationCubit.get(context).bookingSystem[index],
                                context,
                                index),
                            itemCount:  AuthenticationCubit.get(context).bookingSystem.length,
                             //itemCount:  15,
                          ),
                        ],
                      ),
                      fallback: (context) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(),
                        ),
                      )
                  ),
                  Container(
                    // height: sizeFromHeight(context, 3.8),
                    width: sizeFromWidth(context, 1.5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        AuthenticationCubit.get(context).logout(context);
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          },
      ),
    );

  }
}
Widget buildBookingItem(BookModel model, context, index)
//Widget buildBookingItem( context, index)
{
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        // border: Border.all(color: Colors.green, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey, //New
              blurRadius: 10.0,
              offset: Offset(0, 10))
        ],
      ),
      padding: const EdgeInsets.all(20.0),

      child: Column(
        children: [
          Row(

            children: [
              CircleAvatar(
                radius: 30.0,
                child: storyShape(
                   // context, white, NetworkImage((model.image)), 20, 22),
                    context, white, NetworkImage(model.image), 20, 22),
              ),
              SizedBox(
                width: sizeFromWidth(context, 30),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotels name is ${model.name}',
                    style: TextStyle(
                      fontSize: 19.0,

                      color: black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '${model.totalCost} \$',
                    style: TextStyle(
                        fontSize: 23.0,

                        color: Colors.grey
                    ),
                  ),
                ],
              ),
              Spacer(),

            ],
          ),
          SizedBox(
            height: sizeFromHeight(context, 50),
          ),
          Column(
            children: [
              textWidget(
                ' ${model.startDay} to ${model.endDay}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),
              textWidget(
                'Number of Rome :    ${model.numberRome}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),
              textWidget(
                'Number of Rome With Food:    ${model.numberRomeWith}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),

              Container(

                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: () {
                    AuthenticationCubit.get(context).cancelBooking(bookId: model.id,hotelId:model.idHotel, availableRome: (int.parse(model.numberRome)+int.parse(model.numberRomeWith)).toString());

                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: sizeFromHeight(context, 50),
          ),

        ],
      ),
    ),
  );
}
Widget buildBookingItemSystem(BookModel model, context, index)
//Widget buildBookingItem( context, index)
{
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        // border: Border.all(color: Colors.green, width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey, //New
              blurRadius: 10.0,
              offset: Offset(0, 10))
        ],
      ),
      padding: const EdgeInsets.all(20.0),

      child: Column(
        children: [
          Row(

            children: [
              CircleAvatar(
                radius: 30.0,
                child: storyShape(
                  // context, white, NetworkImage((model.image)), 20, 22),
                    context, white, NetworkImage(model.image), 20, 22),
              ),
              SizedBox(
                width: sizeFromWidth(context, 30),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotels name is ${model.name}',
                    style: TextStyle(
                      fontSize: 19.0,

                      color: black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '${model.totalCost} \$',
                    style: TextStyle(
                        fontSize: 23.0,

                        color: Colors.grey
                    ),
                  ),
                ],
              ),

              Spacer(),

            ],
          ),
          Text(
            'Name is ${model.user}',
            style: TextStyle(
              fontSize: 19.0,

              color: black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: sizeFromHeight(context, 50),
          ),
          Column(
            children: [
              textWidget(
                ' ${model.startDay} to ${model.endDay}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),
              textWidget(
                'Number of Rome :    ${model.numberRome}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),
              textWidget(
                'Number of Rome With Food:    ${model.numberRomeWith}  \n',
                TextDirection.ltr,
                null,
                petroleum,
                sizeFromWidth(context, 25),
                FontWeight.w600,
              ),

              Container(

                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: () {
                    AuthenticationCubit.get(context).deleteBookingSystem(bookId: model.id,hotelId:model.idHotel,userId:model.idUser , availableRome: (int.parse(model.numberRome)+int.parse(model.numberRomeWith)).toString());

                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: sizeFromHeight(context, 50),
          ),

        ],
      ),
    ),
  );
}
