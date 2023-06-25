import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:travel/models/Book%20Model.dart';
import 'package:travel/models/Review.dart';
import 'package:travel/models/TouristModel.dart';
import 'package:travel/modules/HomeScreen/booked_points.dart';
import 'package:travel/modules/about_us.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/models/HotelModel.dart';
import 'package:travel/models/UserModel.dart';
import 'package:travel/modules/Authentication/AuthScreen.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/modules/HomeScreen/AboutUs.dart';
import 'package:travel/modules/profileScreens/profile.dart';
import 'package:travel/modules/HomeScreen/tab_screen.dart';
import 'package:travel/modules/TouristScreens/touristic%20places.dart';
import 'package:travel/shared/Components.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:travel/shared/Style.dart';

import '../../HomeScreen/home_Screen.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates>
{
  AuthenticationCubit() : super(AuthenticationInitialState());

  static  AuthenticationCubit get(contex) =>BlocProvider.of(contex);

   Icon suffix= const Icon(Icons.visibility_outlined,color: backgroundColor2,);
   bool isPassword = true;


  void changePasswordVisibility()
   {
     isPassword = !isPassword;
     suffix = isPassword?const Icon(Icons.visibility_outlined,color: backgroundColor2,): const Icon(Icons.visibility_off_outlined,color: backgroundColor2,);

     emit(LoginChangePasswordVisibilityState(),);

   }
   ///////////////////////////
  String startDate = '';
  void selectStartDatePerDay(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2, 3, 5),
      maxTime: DateTime(3500, 6, 7),
      onChanged: (date) {
        startDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      onConfirm: (date) {
        startDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      currentTime: DateTime.now(),
    );
  }
  String endDate = '';
  void selectEndDatePerDay(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2, 3, 5),
      maxTime: DateTime(3500, 6, 7),
      onChanged: (date) {
        endDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      onConfirm: (date) {
        endDate = DateFormat.yMMMd().format(date).toString();
        emit(SelectDatePerDayState());
      },
      currentTime: DateTime.now(),
    );
  }
////////////////////////////////////////////////////////////////////
  int salCost=0;
  int salCostWith=0;
  int sal=0;
  void addSalaryCost(String salary,String cost){
    salCost=0;
    print(salary);
    print(cost);
    print('!^&*(');
    salCost+=(int.parse(salary)*int.parse(cost));
    emit(AddSalaryState());
  }
  void addSalaryCostWith(String salary,String cost){
    salCostWith=0;
    print(salary);
    print(cost);
    print('!^&*(');
    salCostWith+=(int.parse(salary)*int.parse(cost));
    emit(AddSalaryState());
  }
///////////////////////////////////
void booking(HotelModel modell,String romeCost,String romeCostWith,String start,String end,String total,BuildContext context){
  FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
    BookModel model = BookModel(
       user: value['name'],
      idUser: value['id'],
      image:modell.image ,
      name:modell.name ,
      idHotel:modell.id ,
      id:"" ,
      createdAt: Timestamp.now().toString(),
      endDay:end ,
      numberRome: romeCost,
      numberRomeWith:romeCostWith ,
      startDay: start,
      totalCost:total ,

    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('Booking')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('Booking')
          .doc(value.id)
          .update({
        'id': value.id,
      });
      FirebaseFirestore.instance
          .collection('Hotels')
          .doc(modell.id)
          .update({
        'availableRome': (int.parse(modell.availableRome)-(int.parse(romeCost)+int.parse(romeCostWith))).toString(),
      });
      print("!!!!!");
      navigateAndFinish(context, const BookedPoints());
      reviewController.text='';
    });
    print("()()()()");
    emit(ClassificationUserSuccessState());
  }).catchError((error) {
    print(error.toString());
    emit(ClassificationUserErrorState(error.toString()));
  });
}
///////////////////////////////
  void cancelBooking({
  required String hotelId,
  required String bookId,
  required String availableRome,

}){

    FirebaseFirestore.instance
        .collection('Hotels')
        .doc(hotelId)
        .get().then((value) {
      FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hotelId)
          .update({
        'availableRome':(int.parse(value['availableRome'])+int.parse(availableRome)).toString(),
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection('Booking')
          .doc(bookId).delete().then((value) =>  bookUsers());

      emit(CancelBookingSuccessState());
      print("!@!@!@!@!@");
    }).catchError((error){
      print("Enter Error");
      print(error.toString());
      emit(CancelBookingErrorState(error.toString()));
    });

    emit(BookUsersSuccessState());
  }
  void deleteBookingSystem({
    required String hotelId,
    required String bookId,
    required String userId,
    required String availableRome,

  }){

    FirebaseFirestore.instance
        .collection('Hotels')
        .doc(hotelId)
        .get().then((value) {
      FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hotelId)
          .update({
        'availableRome':(int.parse(value['availableRome'])+int.parse(availableRome)).toString(),
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Booking')
          .doc(bookId).delete().then((value){
            bookSystem();
            emit(CancelBookingSuccessState());
          });

      emit(CancelBookingSuccessState());
      print("!@!@!@!@!@");
    }).catchError((error){
      print("Enter Error");
      print(error.toString());
      emit(CancelBookingErrorState(error.toString()));
    });

    emit(BookUsersSuccessState());
  }
///////////////////////////////
  int currentIndex=0;
  List<Widget>screen=[
    const HomeScreen(),
    const TouristicPlaces(),
    const AboutUsScreen(),
    const Profile(),
  ];

  void changePage(int index) {
    if(index==0){
      id=FirebaseAuth.instance.currentUser!.uid.toString();
    //  getGame();
    }
    if(index==1){
     // getAppointment();
    }
    currentIndex = index;
    emit(TabChangeScreenState());
  }
  /////////////////////////////////////
  searchAboutHotels(value) {
    List<HotelModel> searchHotels = [];
    searchHotels = hotels.where((element) {
      var searchItem = element.name.toLowerCase()+ element.place.toLowerCase();
      return searchItem.contains(value.toString().toLowerCase());
    }).toList();
    hotels = [];
    hotels = searchHotels;
    emit(SearchAboutGameState());
  }
  searchAboutTourist(value) {
    List<TouristModel> searchHotels = [];
    searchHotels = tourist.where((element) {
      var searchItem = element.name.toLowerCase()+ element.place.toLowerCase();
      return searchItem.contains(value.toString().toLowerCase());
    }).toList();
    tourist = [];
    tourist = searchHotels;
    emit(SearchAboutGameState());
  }
  /////////////////////////////////////////////////
  void addReview(String hotelId,String review) {
    //
    print(hotelId);
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      ReviewModel model = ReviewModel(
        image:value['image'] ,
        name:value['name'] ,
        id:"" ,
        createdAt: Timestamp.now().toString(),
        review: review,

      );
      FirebaseFirestore.instance
          .collection('Hotels')
          .doc(hotelId)
          .collection('Review')
          .add(model.toMap())
          .then((value) {
        FirebaseFirestore.instance
            .collection('Hotels')
            .doc(hotelId)
            .collection('Review')
            .doc(value.id)
            .update({
          'id': value.id,
        });
        print("!!!!!");
        reviewController.text='';
      });
      print("()()()()");
      emit(ClassificationUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ClassificationUserErrorState(error.toString()));
    });
    print('toao');
    emit(SearchAboutGameState());
  }
  List<ReviewModel> review = [];
  void getReview(String hotelId){
    FirebaseFirestore.instance
        .collection('Hotels')
        .doc(hotelId)
        .collection('Review')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      review = [];
      for (var element in event.docs) {
        review.add(ReviewModel.fromJson(element.data()));
      }
      emit(GetHotelsSuccessState());
    });
  }
  void deleteReview(String hotelId){
    print("Gerges212");
    FirebaseFirestore.instance.collection('Hotels').doc(hotelId).collection('Review').get().then((value){
      for(var i in value.docs){
        print(i['id']);
        print("asher321");
        FirebaseFirestore.instance.collection('Hotels').doc(hotelId).collection('Review').doc(i['id']).delete();
      }
      emit(DeleteReviewSuccessState());
    });
  }
//////////////////////////////////////////////////////////////////////////
  double progress=0;
  void addHotels(BuildContext context, String name,String availableRome,String romeCostWithFood,String romeCost,String description,String place,String rate,) {
    var hotelImage = Uri.file(postImage!.path).pathSegments.last;
    FirebaseStorage.instance
        .ref()
        .child('HotelImage')
        .child(hotelImage)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        var imageUrl = value;
        var videoName = Uri.file(pickedVideo!.path).pathSegments.last;
        FirebaseStorage.instance
            .ref()
            .child('HotelVideo')
            .child(videoName)
            .putFile(pickedVideo!).snapshotEvents
            .listen((value) {
          print('Task state: ${value.state}');
          progress=(value.bytesTransferred / value.totalBytes) * 100;

          if(value.state == TaskState.success){
           value.ref.getDownloadURL().then((value) {
              print("asher");
              print(value);
              HotelModel model = HotelModel(
                image:imageUrl ,
                name:name ,
                id:"" ,
                place: place,
                rate: rate,
                availableRome:availableRome ,
                description:description ,
                romeCost:romeCost ,
                createdAt: Timestamp.now().toString(),
                romeCostWithFood:romeCostWithFood ,
                video: value,
              );
              FirebaseFirestore.instance
                  .collection('Hotels')
                  .add(model.toMap())
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('Hotels')
                    .doc(value.id)
                    .update({
                  'id': value.id,
                });
                print("!!!!!");
                navigateAndFinish(context,const TabScreen());
              });

              pickedVideo = null;
              postImage = null;
              emit(SendVideoSuccessState());
            });
            print('ashergerges');
          }
          emit(SendVideoSuccessState());
        });
      });
        emit(SendVideoSuccessState());
      });


  }
  void addTourist(BuildContext context, String name,String description,String place,String rate,) {
    var hotelImage = Uri.file(postImage!.path).pathSegments.last;
    FirebaseStorage.instance
        .ref()
        .child('TouristImage')
        .child(hotelImage)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        var imageUrl = value;
        var videoName = Uri.file(pickedVideo!.path).pathSegments.last;
        FirebaseStorage.instance
            .ref()
            .child('TouristVideo')
            .child(videoName)
            .putFile(pickedVideo!).snapshotEvents
            .listen((value) {
          print('Task state: ${value.state}');
          progress=(value.bytesTransferred / value.totalBytes) * 100;

          if(value.state == TaskState.success){
            value.ref.getDownloadURL().then((value) {
              print("asher");
              print(value);
              TouristModel model = TouristModel(
                image:imageUrl ,
                name:name ,
                id:"" ,
                place: place,
                rate: rate,
                description:description ,
                createdAt: Timestamp.now().toString(),
                video: value,
              );
              FirebaseFirestore.instance
                  .collection('Tourist')
                  .add(model.toMap())
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('Tourist')
                    .doc(value.id)
                    .update({
                  'id': value.id,
                });
                print("!!!!!");
                navigateAndFinish(context,const TabScreen());
              });

              pickedVideo = null;
              postImage = null;
              emit(SendVideoSuccessState());
            });
            print('ashergerges');
          }
          emit(SendVideoSuccessState());
        });
      });
      emit(SendVideoSuccessState());
    });


  }


  // //////////////////////////////////////////////////////////////////////
  bool isShowSignInDialog = false;

  //////////////////////Login/////////////////
  var emailLogin = TextEditingController();
  var passwordLogin = TextEditingController();
  var commentController = TextEditingController();
  var reviewController = TextEditingController();

  final GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddHotel = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddTourist = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyAddReview = GlobalKey<FormState>();
///////////////////////////////////////////////////////////////////////////
  File? pickedVideo;
  void getVideo() async {
    final pickedFile = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      pickedVideo = File(pickedFile.path);
      showToast(text: 'Video Selected', state: ToastStates.SUCCESS);
      emit(VideoPickedSuccessState());
    } else {
      emit(VideoPickedErrorState());
    }
  }

  ////////////////////////////////SignUP///////////////////////////////////////
  var phoneSignUp = TextEditingController();
  var passwordSignUp = TextEditingController();
  var emailSignUp = TextEditingController();
  var nameSignUp = TextEditingController();
  ////////////////////postScreen////////////////////////////////
  File? postImage;
  String? imageUrl;
  String id='';
  var picker = ImagePicker();
  late final pickedFile;
  Future<void> getPostImage() async {
     pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  Future<void> openPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }
  void removePostImage()
  {
    postImage = null;
    emit(RemovePostImageState());
  }

/////////////////////////////////////////////////////
  TextEditingController searchGameController = TextEditingController();
/////////////////////////Update////////////////////////////
  TextEditingController nameHotelController = TextEditingController();
  TextEditingController descriptionHotelController = TextEditingController();
  TextEditingController placeHotelController = TextEditingController();
  TextEditingController rateHotelController = TextEditingController();
  TextEditingController romeCostHotelController = TextEditingController();
  TextEditingController romeCostWithFoodHotelController = TextEditingController();
  TextEditingController availableRomeHotelController = TextEditingController();
  void datapersone(){

    emit(LoginChangePasswordVisibilityState(),);
  }

//////////////////////////////////////

  void userRegister({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    required String phone,

  }) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      id=FirebaseAuth.instance.currentUser!.uid.toString();
      createUser(
        email: email,
        name: name,
        password: password,
        phone: phone,
        uId: value.user!.uid,
        context: context
      );
      emit(SignUPSuccessState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required BuildContext context,
  }) async {
    emit(PickedImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('studentImage/$uId')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        UserModel model = UserModel(
          name: name,
          email: email,
          password: password,
          phone: phone,
          image: value,
          id: uId,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .set(model.toMap());
          });
      navigateAndFinish(context, const TabScreen());
      emit(SignUPCreateUserSuccessState());
    })
        .catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(SignUPCreateUserErrorState(error.toString()));

    });
     emit(SignUPCreateSuccessState());
  }





  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {


    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      id=FirebaseAuth.instance.currentUser!.uid.toString();
      navigateAndFinish(context, const TabScreen());
      emit(LoginSuccessState());
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.ERROR);
      emit(LoginErrorStateLog(error.toString()));

    });
  }


  void logout(BuildContext context){
    FirebaseAuth.instance.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
    });
  }
  void getUid(){
    id=FirebaseAuth.instance.currentUser!.uid.toString();
    print(id);
    print('!!!!!!!!!');
    emit(LoginSuccessState());
  }
/////////////////////////////////

  String name='';
  String email='';
  String password='';
  String phone='';
  String image='';
  String uid='';
void getProfile(){
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .get().then((value) {
    name = value['name'];
    email = value['email'];
    password = value['password'];
    phone = value['phone'];
    image = value['image'];
    uid = value['id'];
    emit(ProfileSuccessState());
    print("!@!@!@!@!@");
  }).catchError((error){
    print("!@!@!@!@!@");
    print(error.toString());
    emit(ProfileErrorState(error.toString()));
  });
  emit(ProfileSuccessState());
}
///////////////////////////////
List<BookModel>bookingUser=[];
void bookUsers(){
  print('bookUsersEnter');

  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('Booking')
      .get().then((value) {
    bookingUser=[];
        for(var element in value.docs) {
          bookingUser.add(BookModel.fromJson(element.data()));
        }
    emit(BookUsersSuccessState());
    print("!@!@!@!@!@");
  }).catchError((error){
    print("!@!@!@!@!@");
    print(error.toString());
    emit(BookUsersErrorState(error.toString()));
  });
   emit(BookUsersSuccessState());
}
  List<BookModel>bookingSystem=[];
  void bookSystem(){
    print('bookSystemsEnter');

    FirebaseFirestore.instance
        .collection('users')
        .get().then((value) {
      print('saaaaa2');
      bookingSystem=[];
      for(var element in value.docs) {
        print('saaaaa3');
        FirebaseFirestore.instance
            .collection('users')
            .doc(element.id)
            .collection('Booking')
            .get().then((value)  {
          print('saaaaa');
          for(var element in value.docs) {
            bookingSystem.add(BookModel.fromJson(element.data()));
            print("aqqaaq");
          }
          emit(BookUsersSuccessState());
        });
        emit(BookUsersSuccessState());
      }
      emit(BookUsersSuccessState());
      print("!@!@!@!@!@");
    }).catchError((error){
      print("!@!@!@!@!@");
      print(error.toString());
      emit(BookUsersErrorState(error.toString()));
    });
    emit(BookUsersSuccessState());
  }
////////////////////////////
  List<HotelModel> hotels = [];
  void getHotels() {
    FirebaseFirestore.instance
        .collection('Hotels')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      hotels = [];
      for (var element in event.docs) {
        hotels.add(HotelModel.fromJson(element.data()));
      }

    });
    emit(GetHotelsSuccessState());
  }
  void deleteHotels(String id) {
    FirebaseFirestore.instance.collection('Hotels').doc(id).delete();

  }
///////////////////////////

  List<TouristModel> tourist = [];
  void getTourist() {
    FirebaseFirestore.instance
        .collection('Tourist')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      tourist = [];
      for (var element in event.docs) {
        tourist.add(TouristModel.fromJson(element.data()));
      }
      emit(GetHotelsSuccessState());
    });

  }
  void deleteTourist(String id) {

    FirebaseFirestore.instance.collection('Tourist').doc(id).delete();

  }
///////////////////////////
  VideoPlayerController videoPlayer = VideoPlayerController.network('');
  Duration position = Duration.zero;
  bool isPortrait = true;
  bool showControl = true;
  bool isVideoPlay = true;
  void getVideoSeek(value) async {
    videoPlayer.seekTo(Duration(seconds: value.toInt()));
    emit(VideoSeekState());
  }
  void updateSliderPosition() {
    position = videoPlayer.value.position;
    if (videoPlayer.value.position.inSeconds != 0 &&
        videoPlayer.value.position.inSeconds ==
            videoPlayer.value.duration.inSeconds) {
      getVideoSeek(0);
    }
    emit(UpdateSliderPositionState());
  }
  void initVideoPlayer(String model) async {
    // videoPlayer = VideoPlayerController.network(model.video);
    videoPlayer = VideoPlayerController.network(model);
    await videoPlayer.initialize();
    videoPlayer.addListener(updateSliderPosition);
    videoPlayer.play();
    emit(InitVideoPlayerState());
  }
  void changePortraitToLandscape(bool value) {
    if (!value) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      isPortrait = value;
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      isPortrait = value;
    }
    emit(ChangePortraitToLandscapeState());
  }

  void showControlVideo() {
    showControl = !showControl;
    emit(ShowControlVideoState());
  }
  void killVideo() async {

    videoPlayer.removeListener(() {
    });
    videoPlayer.pause();
    videoPlayer.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    emit(KillVideoPlayerState());
  }
  void increaseOrDecrease(bool increase) {
    if (increase) {
      videoPlayer.value.position.inSeconds + 5;
      getVideoSeek(videoPlayer.value.position.inSeconds + 5);
    }
    if (!increase) {
      videoPlayer.value.position.inSeconds - 5;
      getVideoSeek(videoPlayer.value.position.inSeconds - 5);
    }
    emit(IncreaseOrDecrease());
  }
  void pauseAndPlayVideo() {
    if (isVideoPlay) {
      isVideoPlay = false;
      videoPlayer.pause();
    } else {
      isVideoPlay = true;
      videoPlayer.play();
    }
    emit(PauseAndPlayVideo());
  }
//////////////////////////

}
