import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/shared/Components.dart';
import 'package:travel/shared/Style.dart';

class AddHotels extends StatelessWidget {
  const AddHotels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUid(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: backgroundColorDark,
              title: const Text('Add Hotels'),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.formKeyAddHotel,
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            (AuthenticationCubit.get(context).postImage == null)
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: backgroundColor2,

                                      // image: DecorationImage(
                                      //     image: NetworkImage(
                                      //         "https://th.bing.com/th/id/R.4b38b1945e88a36e2308debb1c766e94?rik=15AY1JjLsPP5PQ&pid=ImgRaw&r=0"),
                                      //     fit: BoxFit.cover)
                                    ),
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      size: MediaQuery.of(context).size.width *
                                          0.20,
                                      color: Colors.grey,
                                    ),
                                  )
                                : ClipOval(
                                    child: Image.file(
                                    AuthenticationCubit.get(context).postImage!,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                AuthenticationCubit.get(context).getPostImage();
                              },
                              icon: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueGrey,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: sizeFromWidth(context, 1.2),
                        child: textButton(
                          context,
                          'Select Video',
                          backgroundColor2,
                          white,
                          sizeFromWidth(context, 20),
                          FontWeight.bold,
                          () {
                            cubit.getVideo();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: cubit.nameHotelController,
                        cursorColor: petroleum,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full Name can not empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
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
                        keyboardType: TextInputType.text,
                        controller: cubit.placeHotelController,
                        cursorColor: petroleum,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Place can not empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Place',
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
                        keyboardType: TextInputType.text,
                        controller: cubit.descriptionHotelController,
                        cursorColor: petroleum,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description can not empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'description',
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
                          labelText: 'romeCost',
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
                          labelText: 'romeCostWithFood',
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
                        keyboardType: TextInputType.number,
                        controller: cubit.availableRomeHotelController,
                        cursorColor: petroleum,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Available Rome can not empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'availableRome',
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
                        keyboardType: TextInputType.number,
                        controller: cubit.rateHotelController,
                        cursorColor: petroleum,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Rate Rome can not empty';
                          }
                          else if (int.parse(cubit.rateHotelController.text)>5){
                            return 'Rate Rome can not by up 10 ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Rate',
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

                  SizedBox(
                    height: sizeFromWidth(context, 10.2),
                    width: sizeFromWidth(context, 1.2),
                    child: LiquidLinearProgressIndicator(
                      value: AuthenticationCubit.get(context).progress/100, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(Colors.blue), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors.white, // Defaults to the current Theme's backgroundColor.
                      borderColor: backgroundColor2,
                      borderWidth: 5.0,
                      borderRadius: 12.0,
                      direction: Axis.horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                      center: Text("Loading...${AuthenticationCubit.get(context).progress.toInt()}%"),
                    ),
                  ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 50, top: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: backgroundColor2,
                            // border: Border.all(color: Colors.green, width: 1.5),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey, //New
                                  blurRadius: 10.0,
                                  offset: Offset(0, 10))
                            ],
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => backgroundColor2),
                            ),
                            onPressed: () {
                              if (AuthenticationCubit.get(context).postImage ==
                                  null) {
                                showToast(
                                    text: 'You Must Select image',
                                    state: ToastStates.ERROR);
                              } else {
                                if (AuthenticationCubit.get(context)
                                        .pickedVideo ==
                                    null) {
                                  showToast(
                                      text: 'You Must Select Video',
                                      state: ToastStates.ERROR);
                                } else {
                                  if (AuthenticationCubit.get(context)
                                      .formKeyAddHotel
                                      .currentState!
                                      .validate()) {
                                    AuthenticationCubit.get(context).addHotels(
                                      context,
                                      AuthenticationCubit.get(context)
                                          .nameHotelController
                                          .text
                                          .trim(),
                                      AuthenticationCubit.get(context)
                                          .availableRomeHotelController
                                          .text
                                          .trim(),
                                      AuthenticationCubit.get(context)
                                          .romeCostWithFoodHotelController
                                          .text
                                          .trim(),
                                      AuthenticationCubit.get(context)
                                          .romeCostHotelController
                                          .text
                                          .trim(),
                                      AuthenticationCubit.get(context)
                                          .descriptionHotelController
                                          .text
                                          .trim(),
                                      AuthenticationCubit.get(context)
                                          .placeHotelController
                                          .text
                                          .trim(),AuthenticationCubit.get(context)
                                        .rateHotelController
                                        .text
                                        .trim(),

                                    );
                                  } else {
                                    showToast(
                                        text: 'Try again,and enter right data',
                                        state: ToastStates.ERROR);
                                  }
                                }
                              }

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.check_circle_sharp,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Add Hotel'.toUpperCase(),
                                  style: TextStyle(color: white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
