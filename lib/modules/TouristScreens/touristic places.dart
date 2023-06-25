

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/TouristModel.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/modules/TouristScreens/AddTourist.dart';
import 'package:travel/modules/TouristScreens/touristDetails.dart';
import 'package:travel/shared/Style.dart';

import '../../shared/Components.dart';

class TouristicPlaces extends StatelessWidget {
  const TouristicPlaces({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid()..getTourist(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Tourist"),
              centerTitle:true,
              actions: [

                AuthenticationCubit.get(context).id==systemId?
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: white,
                    child: IconButton(
                      onPressed: () {
                        print('object');
                        print(AuthenticationCubit.get(context).id);
                    
                        navigateTo(context, const AddTourist());
                      },
                      icon: Icon(Icons.add, color: ko),
                    ),
                  ),
                ):
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  // child: CircleAvatar(
                  //   backgroundColor: white,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       print('object');
                  //       print(AuthenticationCubit.get(context).id);
                  //       // GameCubit.get(context).getPassword();
                  //       // navigateTo(context, const AddPerson());
                  //     },
                  //     icon: Icon(Icons.save, color: ko),
                  //   ),
                  // ),
                ),

              ],
              backgroundColor:const Color(0xff1a033b),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: textFormField(
                        controller:AuthenticationCubit.get(context).searchGameController,
                        type: TextInputType.text,
                        validate: (value) {
                          return null;
                        },
                        hint: "Search For Tourist",
                        isExpanded: true,
                        fromLTR: false,
                        onTap: () {
                          AuthenticationCubit.get(context).getTourist();
                        },
                        onChange: (value) {
                          if (AuthenticationCubit.get(context).searchGameController.text ==
                              '' || AuthenticationCubit.get(context).tourist.isEmpty) {
                            AuthenticationCubit.get(context).getTourist();
                          }
                          AuthenticationCubit.get(context).searchAboutTourist(value);


                        }),
                  ),
                  ConditionalBuilder(
                    // condition: true,
                    condition: AuthenticationCubit.get(context).tourist.isNotEmpty,
                    builder: (context) =>  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildGameItem(AuthenticationCubit.get(context).tourist[index] ,context,index);
                      },
                      separatorBuilder: (context, index) =>
                          divider(10, 10, lightGrey),

                      itemCount: AuthenticationCubit.get(context).tourist.length,
                    ),
                    fallback: (context) => Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: materialWidget(
                          context,
                          sizeFromHeight(context, 3, hasAppBar: true),
                          sizeFromWidth(context, 1),
                          20,
                          null,
                          BoxFit.fill,
                          [
                            textWidget(
                              'There are no tourists added',
                              null,
                              null,
                              petroleum,
                              sizeFromWidth(context, 20),
                              FontWeight.bold,
                            ),
                          ],
                          MainAxisAlignment.center,
                          false,
                          10,
                          Colors.amber,
                              () {},
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
  Widget buildGameItem(TouristModel model, context,index)
  {
    if(AuthenticationCubit.get(context).id==systemId){
      return Dismissible(
        background: Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.delete),
        ),
        secondaryBackground: Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Sure Delete"),
                content: const Text(
                    "Do You Want Delete this tourists"),
                actions: <Widget>[

                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel",style: TextStyle(color: const Color(0xff1a033b))),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),

                    child: const Text("Delete",style: TextStyle(color: const Color(0xff1a033b)),),

                  ),
                ],
              );
            },
          );
        },
        onDismissed: (_) {
          AuthenticationCubit.get(context).deleteTourist(model.id);

        },
        key: UniqueKey(),
        child: InkWell(
          onTap: () async {

            navigateTo(context, TouristDetails(model));
          },
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                // border: Border.all(color: Colors.green, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, //New
                      blurRadius: 10.0,
                      offset: Offset(0, 10))
                ],
              ),
              padding: const EdgeInsets.all(20.0),

              child: Stack(
                  children: [

                    Column(
                      children: [

                        Container(
                          height: 350,
                          decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  model.image==null?"https://th.bing.com/th/id/R.4ce37a351178ec7e4e740a8e98f6241d?rik=F7EZ2GbCr%2fsS0Q&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2%2fTravel-PNG-Download-Image.png&ehk=34eA7EbAsQFFtNyG%2fVA%2fSKg3wbLNMtlZrjz3m5G7lxk%3d&risl=&pid=ImgRaw&r=0":model.image,
                                ),
                                fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            //color: Colors.red,
                            // border: Border.all(color: Colors.green, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 10.0,
                                  offset: Offset(0, 10))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeFromHeight(context, 30),
                        ),
                        textWidget(
                          '${model.name} \n',
                          TextDirection.ltr,
                          null,
                          petroleum,
                          sizeFromWidth(context, 25),
                          FontWeight.w600,
                        ),



                      ],
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Row(
                        children: [
                          Icon(Icons.star,color: Colors.amber,),
                          textWidget(
                            ' (${model.rate})',
                            TextDirection.ltr,
                            null,
                            petroleum,
                            sizeFromWidth(context, 25),
                            FontWeight.w600,
                          ),
                        ],
                      ),)
                  ]

              ),
            ),
          ),

        ),
      );
    }
    else{
      return  InkWell(
        onTap: () async {
         navigateTo(context, TouristDetails(model));
        },
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              // border: Border.all(color: Colors.green, width: 1.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 10.0,
                    offset: Offset(0, 10))
              ],
            ),
            padding: const EdgeInsets.all(20.0),

            child: Stack(
                children: [

                  Column(
                    children: [

                      Container(
                        height: 350,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                model.image==null?"https://th.bing.com/th/id/R.4ce37a351178ec7e4e740a8e98f6241d?rik=F7EZ2GbCr%2fsS0Q&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2%2fTravel-PNG-Download-Image.png&ehk=34eA7EbAsQFFtNyG%2fVA%2fSKg3wbLNMtlZrjz3m5G7lxk%3d&risl=&pid=ImgRaw&r=0":model.image,
                              ),
                              fit: BoxFit.fill
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          //color: Colors.red,
                          // border: Border.all(color: Colors.green, width: 1.5),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey, //New
                                blurRadius: 10.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sizeFromHeight(context, 30),
                      ),
                      textWidget(
                        '${model.name} \n',
                        TextDirection.ltr,
                        null,
                        petroleum,
                        sizeFromWidth(context, 25),
                        FontWeight.w600,
                      ),



                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Icon(Icons.star,color: Colors.amber,),
                        textWidget(
                          ' (${model.rate})',
                          TextDirection.ltr,
                          null,
                          petroleum,
                          sizeFromWidth(context, 25),
                          FontWeight.w600,
                        ),
                      ],
                    ),)
                ]

            ),
          ),
        ),

      );
    }


  }
}
