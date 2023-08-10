// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chatapp/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/cubit/auth_cubit/auth_state.dart';
import 'package:chatapp/helper/show_snack_bar.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/signup_screen.dart';
import 'package:chatapp/widgets/constans.dart';
import 'package:chatapp/widgets/widget_button.dart';
import 'package:chatapp/widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class LogInScreen extends StatelessWidget {
  static String iD = 'LogIn';
  String? emailAddress;

  String? passwordAddress;

  GlobalKey<FormState> formstate = GlobalKey();

  bool? loading;
  // bool onPress = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitState) {
          BlocProvider.of<AuthCubit>(context).onPress;
        } else if (state is LogInLoadingState) {
          loading = true;
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2,
            ),
          );
        } else if (state is LogInSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.of(context).pushNamed(ChatScreen.iD);
        } else if (state is LogInFailureState) {
          ShowSnackBar(context, state.errorMessage);
        } else if (state is SUbIconState) {}
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: loading = false,
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
                        'LogIn',
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
                    onChange: (email) {
                      emailAddress = email;
                    },
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Please Enter Your Email Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormFeildWidget(
                      obscureText: BlocProvider.of<AuthCubit>(context).onPress,
                      hintText: 'Enter Your Password ',
                      lableText: 'Password',
                      onChange: (pass) {
                        passwordAddress = pass;
                      },
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      suffixIcon: BlocProvider.of<AuthCubit>(context).onPress
                          ? IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .onPressIcon(onPress: true);
                              })
                          : IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .onPressIcon(onPress: false);
                              },
                            )
                      // suffixIcon: BlocProvider.of<LogInCubit>(context).onPress
                      //     ? if(State is SUbIconState){
                      //       return IconButton(
                      //         icon: const Icon(
                      //           Icons.visibility_off,
                      //           color: Colors.white,
                      //         ),
                      //         onPressed: () {
                      //           if (State is SUbIconState) {
                      //             BlocProvider.of<LogInCubit>(context).onPress;
                      //           }
                      //         },
                      //       )
                      //     }
                      //     : IconButton(
                      //         icon: const Icon(
                      //           Icons.visibility,
                      //           color: Colors.blue,
                      //         ),
                      //         onPressed: () {
                      //           if (State is SUbIconState) {
                      //             !BlocProvider.of<LogInCubit>(context).onPress;
                      //           }

                      //
                      //         },
                      //       ),
                      ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonWidget(
                    buttonText: 'LOGIN',
                    onTab: () async {
                      if (formstate.currentState!.validate()) {
                        BlocProvider.of<AuthCubit>(context).loading = true;
                        await BlocProvider.of<AuthCubit>(context).LogIn(
                          emailAddress: emailAddress!,
                          passwordAddress: passwordAddress!,
                        );
                        BlocProvider.of<AuthCubit>(context).loading = false;
                      }
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
                        'don\'t have any account ?',
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
                          Navigator.of(context).pushNamed(SignUpScreen.iD);
                        },
                        child: const Text(
                          'Register',
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
      ),
    );
  }

  // LogIn(BuildContext context) async {
  //   if (formstate.currentState!.validate()) {
  //     BlocProvider.of<LogInCubit>(context).loading = true;

  //     // try {
  //     //   final credential =
  //     //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     //     email: emailAddress!,
  //     //     password: passwordAddress!,
  //     //   );

  //     //   Navigator.of(context).push(
  //     //     MaterialPageRoute(
  //     //       builder: (context) => ChatScreen(),
  //     //     ),
  //     //   );
  //     // } on FirebaseAuthException catch (e) {
  //     //   if (e.code == 'user-not-found') {
  //     //     ShowSnackBar(context, 'No user found for that email');
  //     //   } else if (e.code == 'wrong-password') {
  //     //     ShowSnackBar(context, 'Wrong password provided for that user');
  //     //   }
  //     // } catch (e) {
  //     //   return e.toString();
  //     // }

  //     loading = false;
  //   }
  // }
}
