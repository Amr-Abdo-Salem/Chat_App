abstract class AuthEvent {}

class LogInEvent extends AuthEvent {
  final String emailAddress;
  final String passwordAddress;

  LogInEvent({required this.emailAddress, required this.passwordAddress});
}

class SignUpEvent extends AuthEvent {}
