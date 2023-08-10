// ignore_for_file: avoid_print

import 'package:chatapp/Blocs/auth_Bloc/auth_event.dart';
import 'package:chatapp/Blocs/auth_Bloc/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitState()) {
    on<AuthEvent>((event, emit) async {
      if (event is LogInEvent) {
        try {
          emit(LogInLoadingState());
          // ignore: unused_local_variable
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.emailAddress,
            password: event.passwordAddress,
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
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
