// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:chatapp/cubit/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitState());

  bool loading = false;
  bool onPress = true;

  LogIn({
    required String emailAddress,
    required String passwordAddress,
  }) async {
    try {
      emit(LogInLoadingState());
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: passwordAddress,
      );
      emit(LogInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LogInFailureState(errorMessage: 'User Not Found'));
      } else if (e.code == 'wrong-password') {
        emit(LogInFailureState(errorMessage: 'Wrong Password'));
      }
    } catch (e) {
      emit(LogInFailureState(errorMessage: 'Something Went Wrong'));
      print(e);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  onPressIcon({required bool onPress}) {
    if (onPress = true) {
      onPress = !onPress;
    }
    print(onPress);
    emit(AuthInitState());
  }

  SignUp({required String emailAddress, required String emailPassword}) async {
    try {
      emit(SignUpLoadingState());
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: emailPassword,
      );
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailureState(errorMessage: 'Weak Password !'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailureState(errorMessage: 'Email Already Is Used !'));
      }
    } catch (e) {
      emit(SignUpFailureState(errorMessage: 'Something Wont Wrong !'));
      print(e);
    }
  }
}
