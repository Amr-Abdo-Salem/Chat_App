// ignore_for_file: non_constant_identifier_names, must_be_immutable
// ignore: avoid_web_libraries_in_flutter
import 'package:chatapp/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/cubit/auth_cubit/auth_state.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/widgets/constans.dart';
import 'package:chatapp/widgets/widget_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/widget_textfield.dart';

// ignore: use_key_in_widget_constructors
class SignUpScreen extends StatelessWidget {
  String? emailAddress;
  static String iD = 'SignUp';

  String? emailPassword;

  GlobalKey<FormState> formstate = GlobalKey();

  bool isInAsyncCall = false;
  bool onPress = false;
  DocumentReference user =
      FirebaseFirestore.instance.collection(kUserCollection).doc(uID);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          isInAsyncCall = true;
        } else if (state is SignUpSuccessState) {
          Navigator.of(context).pushNamed(ChatScreen.iD);
        } else if (state is SignUpFailureState) {
          ShowSnackBar(context, state.errorMessage);
          isInAsyncCall = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isInAsyncCall,
          child: Scaffold(
            backgroundColor: kPrimareColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    const Text(
                      'Scholar Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Row(
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormFeildWidget(
                      hintText: 'Enter Your Email ',
                      lableText: 'Email',
                      onChange: (value) {
                        emailAddress = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Please Enter Email Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormFeildWidget(
                      obscureText: onPress,
                      hintText: 'Enter Your Password ',
                      lableText: 'Password',
                      suffixIcon: onPress
                          ? IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // onPress = !onPress;
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                //  onPress = !onPress;
                              },
                            ),
                      onChange: (value) {
                        emailPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email Address';
                        } else if (value.length < 8) {
                          return 'Your Password Less Than 8 ELement';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      buttonText: 'RIGESTER',
                      onTab: () {
                        if (formstate.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).SignUp(
                            emailAddress: emailAddress!,
                            emailPassword: emailPassword!,
                          );
                        }
                        user.set({
                          'EmailAddress':
                              FirebaseAuth.instance.currentUser!.email,
                          'Password': emailPassword,
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'alredy have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // SignUp() async {
  //   if (formstate.currentState!.validate()) {

  //       isInAsyncCall = true;

  //     try {
  //       // ignore: unused_local_variable
  //       final credential =
  //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: emailAddress!,
  //         password: emailPassword!,
  //       );

  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => ChatScreen(),
  //         ),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         // ignore: use_build_context_synchronously
  //         ShowSnackBar(
  //           context,
  //           'The password provided is too weak.',
  //         );
  //       } else if (e.code == 'email-already-in-use') {
  //         // ignore: use_build_context_synchronously
  //         ShowSnackBar(
  //           context,
  //           'The account already exists for that email',
  //         );
  //       }
  //     } catch (e) {
  //       return (e);
  //     }
  //     setState(
  //       () {
  //         isInAsyncCall = false;
  //       },
  //     );

  //     Future.delayed(const Duration(milliseconds: 5), () {
  //       Navigator.of(context).pop();
  //     });
  //   }
  // }
}
