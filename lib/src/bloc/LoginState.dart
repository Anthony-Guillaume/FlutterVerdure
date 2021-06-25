import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:verdure/src/data/entity/Email.dart';
import 'package:verdure/src/data/entity/Password.dart';
import 'package:verdure/src/data/entity/Username.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Email email;
  final Password password;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Email? email,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, email, password];
}
