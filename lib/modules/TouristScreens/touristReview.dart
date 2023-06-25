import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/Review.dart';
import 'package:travel/models/TouristModel.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/shared/Style.dart';

import '../../models/HotelModel.dart';
import '../../shared/Components.dart';

class TouristReview extends StatelessWidget {
  TouristModel model;

  TouristReview(this.model, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid()..getReview(model.id),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title:  Text("Review of ${model.name}"),
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
                        // GameCubit.get(context).getPassword();
                        AuthenticationCubit.get(context).deleteReview(model.id);
                      },
                      icon: Icon(Icons.delete, color: ko),
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
                  Form(
                    key: AuthenticationCubit.get(context).formKeyAddReview,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Container(
                            height: sizeFromHeight(context, 6.2),
                            width: double.infinity,
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
                            child: Column(
                              children: [

                                Expanded(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Review can not empty';
                                      }
                                      return null;
                                    },
                                    controller: AuthenticationCubit.get(context).reviewController,
                                    decoration: const InputDecoration(
                                      hintText: 'Review ...',
                                      hintStyle: TextStyle(color: backgroundColor2,fontSize: 22),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                defaultButton(
                                  height: sizeFromHeight(context, 18),
                                  width:sizeFromWidth(context, 1.7) ,
                                  background: backgroundColor2,
                                  border: backgroundColor2,
                                  function: ()
                                  {
                                    if(AuthenticationCubit.get(context).formKeyAddReview.currentState!.validate())
                                    {

                                      AuthenticationCubit.get(context).addReview( model.id,AuthenticationCubit.get(context).reviewController.text);
                                    }
                                    else{
                                      //AppBarCubit.get(context).ErrorBook( context,AppLayout());
                                    }
                                  },
                                  text: 'Submit',
                                  textColor: Colors.white,
                                ),

                              ],
                            ),
                          ),
                          //////


                        ],
                      ),
                    ),
                  ),
                  ConditionalBuilder(
                    // condition: true,
                    condition: AuthenticationCubit.get(context).review.isNotEmpty,

                    builder: (context) =>  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildHotelReview(AuthenticationCubit.get(context).review[index] ,context,index);
                        //return buildHotelReview(context,index);
                      },
                      separatorBuilder: (context, index) =>
                          divider(10, 10, lightGrey),

                      itemCount: AuthenticationCubit.get(context).review.length,
                     //itemCount: 15,
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
                              'There are no hotels added',
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
}
Widget buildHotelReview(ReviewModel model,context,index)
{
  return Padding(
    padding: const EdgeInsets.all(15),
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
      padding: EdgeInsets.only( top: 15,left: 5,bottom: 20,right: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage(model.image),
                    radius: 35.0,
                  ),
                  SizedBox(width: 15.0),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.name,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold)),

                    ],
                  ),
                ],
              ),

            ],
          ),
          SizedBox(height: 2,),
          Padding(
            padding: const EdgeInsets.only(left: 68.0),
            child: Column(
              children: [
                textWidget(
                  model.review,
                  TextDirection.ltr,
                  null,
                  petroleum,
                  sizeFromWidth(context, 25),
                  FontWeight.w600,
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );

}
