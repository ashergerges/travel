import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/modules/Authentication/cubit/cubit.dart';
import 'package:travel/modules/Authentication/cubit/states.dart';
import 'package:travel/shared/Components.dart';
import 'package:travel/shared/Style.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: ()
                    {
                      AuthenticationCubit.get(context).getPostImage();
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.20,
                      backgroundColor: Colors.white,
                      backgroundImage: AuthenticationCubit.get(context).postImage==null ? null : FileImage(File(AuthenticationCubit.get(context).pickedFile!.path)),
                      child: AuthenticationCubit.get(context).postImage == null
                          ?
                      Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      ) : null,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Form(
                    key: AuthenticationCubit.get(context).formKeySignUp,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(

                            child: TextFormField(

                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Full Name can not empty';
                                }
                                return null;

                              },
                              controller: AuthenticationCubit.get(context).nameSignUp,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                //border: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: backgroundColor2,
                                ),

                              ),
                              keyboardType:TextInputType.name,
                              onFieldSubmitted: (value){

                              },
                              onChanged: (value){

                              },

                            ),
                          ),
                        ),
                        SizedBox(
                          //height: 10.0,
                          height: sizeFromHeight(context, 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(

                            child: TextFormField(
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Email can not empty';
                                }
                                else if(!value.contains('@gmail.com'))
                                {
                                  return 'please enter a valid email address';
                                }
                                return null;


                              },
                              controller: AuthenticationCubit.get(context).emailSignUp,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                //border: InputBorder.none,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),
                                prefixIcon: const Icon(
                                    Icons.email,
                                    color: backgroundColor2
                                ),

                              ),
                              keyboardType:TextInputType.emailAddress,
                              onFieldSubmitted: (value){

                              },
                              onChanged: (value){

                              },

                            ),
                          ),
                        ),
                        SizedBox(

                          height: sizeFromHeight(context, 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(

                            child: TextFormField(

                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'phone can not empty';
                                }
                                else if (value.length>11)
                                {
                                  return 'phone number must consist of 11 ';
                                }
                                else if (value.length<11)
                                {
                                  return 'phone number must consist of 11 ';
                                }
                                return null;

                              },
                              controller: AuthenticationCubit.get(context).phoneSignUp,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',

                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(17.0)),

                                prefixIcon: const Icon(
                                    Icons.phone_android_outlined,
                                    color: backgroundColor2
                                ),

                              ),
                              keyboardType:TextInputType.number,
                              onFieldSubmitted: (value){

                              },
                              onChanged: (value){

                              },

                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFromHeight(context, 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(

                            child: defaultFormField(
                              emailAddress: AuthenticationCubit.get(context).passwordSignUp,
                              text: 'Password',
                              returnSyntex: 'password can not empty',
                              prefixicon: const Icon(Icons.lock,color: backgroundColor2),
                              keyboardtype: TextInputType.visiblePassword,
                              ispassword: AuthenticationCubit.get(context).isPassword ,
                              suffix: AuthenticationCubit.get(context).suffix,
                              suffixPressed: ()
                              {
                                AuthenticationCubit.get(context).changePasswordVisibility();
                              },


                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeFromHeight(context, 60),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: backgroundColor2,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    ),
                    onPressed: ()
                    {
                      if(AuthenticationCubit.get(context).postImage==null){
                        showToast(text: 'You Must Select image',state: ToastStates.ERROR);
                      }
                      else{
                        if (AuthenticationCubit.get(context).formKeySignUp.currentState!.validate()) {
                          AuthenticationCubit.get(context).userRegister(
                            name: AuthenticationCubit.get(context).nameSignUp.text.trim(),
                            phone:AuthenticationCubit.get(context).phoneSignUp.text.trim() ,
                            email: AuthenticationCubit.get(context).emailSignUp.text.trim(),
                            password: AuthenticationCubit.get(context).passwordSignUp.text.trim(),
                            context: context
                          );
                        }
                        else{
                          showToast(text: 'Try again,and enter right data',state: ToastStates.ERROR);
                        }
                      }

                      // formValidation();
                    },
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
