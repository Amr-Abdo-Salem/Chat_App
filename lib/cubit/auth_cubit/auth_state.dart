abstract class AuthState {}

class AuthInitState extends AuthState {}

class LogInLoadingState extends AuthState {}

class LogInSuccessState extends AuthState {}

class LogInFailureState extends AuthState {
  String errorMessage;
  LogInFailureState({
    required this.errorMessage,
  });
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  String errorMessage;

  SignUpFailureState({
    required this.errorMessage,
  });
}

class SUbIconState extends AuthState {}
