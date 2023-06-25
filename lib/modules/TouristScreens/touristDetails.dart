import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/TouristModel.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/modules/TouristScreens/touristReview.dart';
import 'package:travel/shared/Components.dart';
import 'package:travel/shared/Style.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

class TouristDetails extends StatelessWidget {
  TouristModel model;

  TouristDetails(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthenticationCubit()..initVideoPlayer(model.video),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              bool isPortrait = orientation == Orientation.portrait;
              return Scaffold(
                  backgroundColor: white,
                  appBar: AuthenticationCubit.get(context).isPortrait
                      ? AppBar(
                          backgroundColor: const Color(0xff1a033b),
                          elevation: 0,
                          title: Text(model.name),
                          centerTitle: true,
                          leading: IconButton(
                            onPressed: () {
                              AuthenticationCubit.get(context).killVideo();
                              navigatePop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: white),
                          ),
                        )
                      : null,
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        isPortrait
                            ? videoPortrait(context, isPortrait)
                            : videoLandscape(context, isPortrait),
                        Padding(
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
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, right: 10, top: 10),
                                      child: Column(
                                        children: [
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
                                                  'Name of Tourist',
                                                  TextDirection.rtl,
                                                  null,
                                                  orange,
                                                  sizeFromWidth(context, 20),
                                                  FontWeight.bold,
                                                ),
                                                textWidget(
                                                  model.name,
                                                  TextDirection.rtl,
                                                  null,
                                                  white,
                                                  sizeFromWidth(context, 25),
                                                  FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20,),
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
                                                  'Place Name',
                                                  TextDirection.rtl,
                                                  null,
                                                  orange,
                                                  sizeFromWidth(context, 20),
                                                  FontWeight.bold,
                                                ),
                                                textWidget(
                                                  model.place,
                                                  TextDirection.rtl,
                                                  null,
                                                  white,
                                                  sizeFromWidth(context, 25),
                                                  FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20,),
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
                                                  'Description',
                                                  TextDirection.rtl,
                                                  null,
                                                  orange,
                                                  sizeFromWidth(context, 20),
                                                  FontWeight.bold,
                                                ),
                                                textWidget(
                                                  model.description,
                                                  TextDirection.rtl,
                                                  null,
                                                  white,
                                                  sizeFromWidth(context, 25),
                                                  FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(height: 20,),
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
                                                  'Tourist Rate',
                                                  TextDirection.rtl,
                                                  null,
                                                  orange,
                                                  sizeFromWidth(context, 20),
                                                  FontWeight.bold,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.star,color: Colors.amber,),
                                                    textWidget(
                                                      ' (${model.rate})',
                                                      TextDirection.ltr,
                                                      null,
                                                      white,
                                                      sizeFromWidth(context, 25),
                                                      FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20,),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
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
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, right: 10, top: 10),
                                      child: Column(
                                        children: [
                                          InkWell(
                                             onTap: (){

                                              navigateTo(context,  TouristReview(model));
                                             },
                                            child: Container(
                                              padding: EdgeInsets.all(10),

                                              width:  sizeFromWidth(context, 1),
                                              decoration:  BoxDecoration(
                                                color: ko,
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                                                    'See Review',
                                                    TextDirection.rtl,
                                                    null,
                                                    orange,
                                                    sizeFromWidth(context, 20),
                                                    FontWeight.bold,
                                                  ),
                                                  textWidget(
                                                    'Kick here',
                                                    TextDirection.rtl,
                                                    null,
                                                    white,
                                                    sizeFromWidth(context, 25),
                                                    FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20,),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

Widget videoPortrait(BuildContext context, bool isPortrait) {
  return Padding(
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
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                width: sizeFromWidth(context, 1),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (AuthenticationCubit.get(context)
                        .videoPlayer
                        .value
                        .isInitialized)
                      AspectRatio(
                        aspectRatio: AuthenticationCubit.get(context)
                            .videoPlayer
                            .value
                            .aspectRatio,
                        child: VideoPlayer(
                            AuthenticationCubit.get(context).videoPlayer),
                      ),
                    if (!AuthenticationCubit.get(context)
                        .videoPlayer
                        .value
                        .isInitialized)
                      circularProgressIndicator(white, petroleum),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Slider.adaptive(
                      activeColor: petroleum,
                      inactiveColor: lightGrey,
                      value: AuthenticationCubit.get(context)
                          .position
                          .inSeconds
                          .toDouble(),
                      min: 0.0,
                      max: AuthenticationCubit.get(context)
                          .videoPlayer
                          .value
                          .duration
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        AuthenticationCubit.get(context).updateSliderPosition();
                        AuthenticationCubit.get(context).getVideoSeek(value);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AuthenticationCubit.get(context).position.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).position.inSeconds.remainder(60))} ',
                      style: TextStyle(
                          color: petroleum,
                          fontSize: sizeFromWidth(context, 20)),
                    ),
                    Text(
                      '${AuthenticationCubit.get(context).videoPlayer.value.duration.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).videoPlayer.value.duration.inSeconds.remainder(60))} ',
                      style: TextStyle(
                          color: petroleum,
                          fontSize: sizeFromWidth(context, 20)),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  materialButtonIcon(
                    context,
                    Icons.fast_rewind_rounded,
                    sizeFromWidth(context, 10),
                    petroleum,
                    white,
                    () {
                      AuthenticationCubit.get(context)
                          .increaseOrDecrease(false);
                    },
                  ),
                  materialButtonIcon(
                    context,
                    AuthenticationCubit.get(context).isVideoPlay
                        ? Icons.pause
                        : Icons.play_arrow,
                    sizeFromWidth(context, 10),
                    petroleum,
                    white,
                    () {
                      AuthenticationCubit.get(context).pauseAndPlayVideo();
                    },
                  ),
                  materialButtonIcon(
                    context,
                    Icons.fast_forward_rounded,
                    sizeFromWidth(context, 10),
                    petroleum,
                    white,
                    () {
                      AuthenticationCubit.get(context).increaseOrDecrease(true);
                    },
                  ),
                  const Spacer(),
                  // materialButtonIcon(
                  //   context,
                  //   Icons.fullscreen,
                  //   sizeFromWidth(context, 10),
                  //   petroleum,
                  //   white,
                  //       () {
                  //     if (isPortrait) {
                  //       AutoOrientation.landscapeRightMode();
                  //     } else {
                  //       AutoOrientation.portraitUpMode();
                  //     }
                  //     AuthenticationCubit.get(context).changePortraitToLandscape(false);
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
  // return SizedBox(
  //   width: sizeFromWidth(context, 1),
  //   height: sizeFromHeight(context, 1, hasAppBar: true),
  //   child: Column(
  //     children: [
  //       SizedBox(
  //         width: sizeFromWidth(context, 1),
  //         height: sizeFromHeight(context, 2.8, hasAppBar: true),
  //         child: Stack(
  //           alignment: Alignment.bottomCenter,
  //           children: [
  //             if (AuthenticationCubit.get(context).videoPlayer.value.isInitialized)
  //               AspectRatio(
  //                 aspectRatio:
  //                 AuthenticationCubit.get(context).videoPlayer.value.aspectRatio,
  //                 child: VideoPlayer(AuthenticationCubit.get(context).videoPlayer),
  //               ),
  //             if (!AuthenticationCubit.get(context).videoPlayer.value.isInitialized)
  //               circularProgressIndicator(white, petroleum),
  //           ],
  //         ),
  //       ),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: Slider.adaptive(
  //               activeColor: petroleum,
  //               inactiveColor: lightGrey,
  //               value: AuthenticationCubit.get(context).position.inSeconds.toDouble(),
  //               min: 0.0,
  //               max: AuthenticationCubit.get(context)
  //                   .videoPlayer
  //                   .value
  //                   .duration
  //                   .inSeconds
  //                   .toDouble(),
  //               onChanged: (value) {
  //                 AuthenticationCubit.get(context).updateSliderPosition();
  //                 AuthenticationCubit.get(context).getVideoSeek(value);
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               '${AuthenticationCubit.get(context).position.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).position.inSeconds.remainder(60))} ',
  //               style: TextStyle(
  //                   color: petroleum, fontSize: sizeFromWidth(context, 20)),
  //             ),
  //             Text(
  //               '${AuthenticationCubit.get(context).videoPlayer.value.duration.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).videoPlayer.value.duration.inSeconds.remainder(60))} ',
  //               style: TextStyle(
  //                   color: petroleum, fontSize: sizeFromWidth(context, 20)),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           materialButtonIcon(
  //             context,
  //             Icons.fast_rewind_rounded,
  //             sizeFromWidth(context, 10),
  //             petroleum,
  //             white,
  //                 () {
  //                   AuthenticationCubit.get(context).increaseOrDecrease(false);
  //             },
  //           ),
  //           materialButtonIcon(
  //             context,
  //             AuthenticationCubit.get(context).isVideoPlay
  //                 ? Icons.pause
  //                 : Icons.play_arrow,
  //             sizeFromWidth(context, 10),
  //             petroleum,
  //             white,
  //                 () {
  //                   AuthenticationCubit.get(context).pauseAndPlayVideo();
  //             },
  //           ),
  //           materialButtonIcon(
  //             context,
  //             Icons.fast_forward_rounded,
  //             sizeFromWidth(context, 10),
  //             petroleum,
  //             white,
  //                 () {
  //                   AuthenticationCubit.get(context).increaseOrDecrease(true);
  //             },
  //           ),
  //           const Spacer(),
  //           materialButtonIcon(
  //             context,
  //             Icons.fullscreen,
  //             sizeFromWidth(context, 10),
  //             petroleum,
  //             white,
  //                 () {
  //               if (isPortrait) {
  //                 AutoOrientation.landscapeRightMode();
  //               } else {
  //                 AutoOrientation.portraitUpMode();
  //               }
  //               AuthenticationCubit.get(context).changePortraitToLandscape(false);
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   ),
  // );
}

Widget videoLandscape(BuildContext context, bool isPortrait) {
  return InkWell(
    onTap: () {
      AuthenticationCubit.get(context).showControlVideo();
    },
    child: Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              if (AuthenticationCubit.get(context)
                  .videoPlayer
                  .value
                  .isInitialized)
                AspectRatio(
                  aspectRatio: AuthenticationCubit.get(context)
                      .videoPlayer
                      .value
                      .aspectRatio,
                  child:
                      VideoPlayer(AuthenticationCubit.get(context).videoPlayer),
                ),
              if (!AuthenticationCubit.get(context)
                  .videoPlayer
                  .value
                  .isInitialized)
                circularProgressIndicator(white, petroleum),
              if (AuthenticationCubit.get(context).showControl)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    materialButtonIcon(
                      context,
                      Icons.fast_rewind_rounded,
                      sizeFromWidth(context, 10),
                      white,
                      white,
                      () {
                        AuthenticationCubit.get(context)
                            .increaseOrDecrease(false);
                      },
                    ),
                    materialButtonIcon(
                      context,
                      AuthenticationCubit.get(context).isVideoPlay
                          ? Icons.pause
                          : Icons.play_arrow,
                      sizeFromWidth(context, 10),
                      white,
                      white,
                      () {
                        AuthenticationCubit.get(context).pauseAndPlayVideo();
                      },
                    ),
                    materialButtonIcon(
                      context,
                      Icons.fast_forward_rounded,
                      sizeFromWidth(context, 10),
                      white,
                      white,
                      () {
                        AuthenticationCubit.get(context)
                            .increaseOrDecrease(true);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (AuthenticationCubit.get(context).showControl)
          Row(
            children: [
              Expanded(
                child: Slider.adaptive(
                  activeColor: petroleum,
                  inactiveColor: lightGrey,
                  value: AuthenticationCubit.get(context)
                      .position
                      .inSeconds
                      .toDouble(),
                  min: 0.0,
                  max: AuthenticationCubit.get(context)
                      .videoPlayer
                      .value
                      .duration
                      .inSeconds
                      .toDouble(),
                  onChanged: (value) {
                    AuthenticationCubit.get(context).updateSliderPosition();

                    AuthenticationCubit.get(context).getVideoSeek(value);
                  },
                ),
              ),
              Text(
                '${AuthenticationCubit.get(context).position.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).position.inSeconds.remainder(60))} ',
                style: TextStyle(
                    color: petroleum, fontSize: sizeFromWidth(context, 30)),
              ),
              Text(
                '/ ${AuthenticationCubit.get(context).videoPlayer.value.duration.inMinutes.remainder(60)}:${(AuthenticationCubit.get(context).videoPlayer.value.duration.inSeconds.remainder(60))} ',
                style: TextStyle(
                    color: petroleum, fontSize: sizeFromWidth(context, 30)),
              ),
              materialButtonIcon(
                context,
                Icons.fullscreen,
                sizeFromWidth(context, 20),
                petroleum,
                white,
                () {
                  if (isPortrait) {
                    AutoOrientation.landscapeRightMode();
                  } else {
                    AutoOrientation.portraitUpMode();
                  }
                  AuthenticationCubit.get(context)
                      .changePortraitToLandscape(true);
                },
              ),
            ],
          ),
      ],
    ),
  );
}
