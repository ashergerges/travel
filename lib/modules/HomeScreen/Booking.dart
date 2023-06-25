import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/HotelModel.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/shared/Components.dart';
import 'package:travel/shared/Style.dart';

class Booking extends StatelessWidget {
  HotelModel model;

  Booking(this.model, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff1a033b),
            elevation: 0,
            title: Text('Booking in ${model.name} Hotel'),
            centerTitle: true,

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
                          height: sizeFromHeight(context, 1.5),
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
                              Text('Choose the days that make you happy. ',style: TextStyle(fontSize: 23,fontWeight: FontWeight.w900),),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(

                                    children: [
                                       textButton(
                                        context,
                                        'from: ${AuthenticationCubit.get(context).startDate}',
                                        ko,
                                        orange,
                                        sizeFromWidth(context, 25),
                                        FontWeight.w800,
                                            () {
                                              AuthenticationCubit.get(context)
                                              .selectStartDatePerDay(context);
                                        },
                                      ),

                                      textButton(
                                        context,
                                        'to: ${AuthenticationCubit.get(context).endDate}',
                                        ko,
                                        orange,
                                        sizeFromWidth(context, 25),
                                        FontWeight.w800,
                                            () {
                                              AuthenticationCubit.get(context)
                                              .selectEndDatePerDay(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(10),

                                width:  sizeFromWidth(context, 1),
                                decoration:  BoxDecoration(
                                  color: ko,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  // image: DecorationImage(
                                  //   image: image ?? const AssetImage('assets/images/logo.png'),
                                  //
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, //New
                                        blurRadius: 10.0,
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    textWidget(
                                      'Available Rome',
                                      TextDirection.rtl,
                                      null,
                                      orange,
                                      sizeFromWidth(context, 20),
                                      FontWeight.bold,
                                    ),
                                    textWidget(
                                      model.availableRome,
                                      TextDirection.rtl,
                                      null,
                                      white,
                                      sizeFromWidth(context, 25),
                                      FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                  onTap: () {
                                    AuthenticationCubit.get(context).addSalaryCost(cubit.romeCostHotelController.text,model.romeCost);
                                  },
                                  onChanged: (value) {

                                    AuthenticationCubit.get(context).addSalaryCost(cubit.romeCostHotelController.text,model.romeCost);


                                  },
                                keyboardType: TextInputType.number,
                                controller: cubit.romeCostHotelController,
                                cursorColor: petroleum,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Rome Cost can not empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'How many rome ',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: petroleum,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ko),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                onTap: () {
                                  AuthenticationCubit.get(context).addSalaryCostWith(cubit.romeCostWithFoodHotelController.text,model.romeCostWithFood);
                                },
                                onChanged: (value) {

                                  AuthenticationCubit.get(context).addSalaryCostWith(cubit.romeCostWithFoodHotelController.text,model.romeCostWithFood);


                                },
                                keyboardType: TextInputType.number,
                                controller: cubit.romeCostWithFoodHotelController,
                                cursorColor: petroleum,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Rome Cost With Food can not empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'How many rome With Food',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: petroleum,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ko),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const SizedBox(
                                height: 1.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),

                                width:  sizeFromWidth(context, 1),
                                decoration:  BoxDecoration(
                                  color: ko,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  // image: DecorationImage(
                                  //   image: image ?? const AssetImage('assets/images/logo.png'),
                                  //
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, //New
                                        blurRadius: 10.0,
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    textWidget(
                                      'Total Cost',
                                      TextDirection.rtl,
                                      null,
                                      orange,
                                      sizeFromWidth(context, 20),
                                      FontWeight.bold,
                                    ),
                                    textWidget(
                                      '${AuthenticationCubit.get(context).salCost+AuthenticationCubit.get(context).salCostWith} \$',
                                      TextDirection.rtl,
                                      null,
                                      white,
                                      sizeFromWidth(context, 25),
                                      FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),

                              Spacer(),
                              defaultButton(
                                height: sizeFromHeight(context, 18),
                                width:sizeFromWidth(context, 1.7) ,
                                background: ko,
                                border: backgroundColor2,
                                function: ()
                                {
                                  if(AuthenticationCubit.get(context).startDate==''||AuthenticationCubit.get(context).endDate=='')
                                  {
                                    showToast(text: 'You Must Select Data',state: ToastStates.ERROR);

                                  }
                                  else{

                                   if((int.parse(cubit.romeCostHotelController.text==''?'0':cubit.romeCostHotelController.text)+int.parse(cubit.romeCostWithFoodHotelController.text==''?'0':cubit.romeCostWithFoodHotelController.text))>int.parse(model.availableRome)){
                                     showToast(text: 'You Must Select Available Number of room ',state: ToastStates.ERROR);
                                    }
                                   else{

                                     AuthenticationCubit.get(context).booking(
                                         model,
                                         cubit.romeCostHotelController.text==''?'0':cubit.romeCostHotelController.text,
                                         cubit.romeCostWithFoodHotelController.text==''?'0':cubit.romeCostWithFoodHotelController.text,
                                         cubit.startDate,
                                         cubit.endDate,
                                         ((int.parse(cubit.romeCostHotelController.text==''?'0':cubit.romeCostHotelController.text )*int.parse(model.romeCost))+(int.parse(cubit.romeCostWithFoodHotelController.text==''?'0':cubit.romeCostWithFoodHotelController.text))*int.parse(model.romeCostWithFood)).toString(),
                                         context);
                                   }
                                  }




                                  // else{
                                  //   //AppBarCubit.get(context).ErrorBook( context,AppLayout());
                                  // }
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


              ],
            ),
          ),
          );
        },
      ),
    );
  }
}
