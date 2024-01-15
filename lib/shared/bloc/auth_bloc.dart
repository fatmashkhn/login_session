import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

// Event
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class LogoutEvent extends AuthEvent {}

// State
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  final String token;

  AuthenticatedState({required this.token});
}

class AuthenticationErrorState extends AuthState {
  final String error;

  AuthenticationErrorState({required this.error});
}

class UnauthenticatedState extends AuthState {}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      try {
        // Replace with your API endpoint and request body
        final response = await http.post(
          Uri.parse(
              'https://misbahreactprogrammer.000webhostapp.com/api/users'),
          body: {
            'username': event.username,
            'password': event.password,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          // Check if the 'status' is 200
          if (data['status'] == 200) {
            final Map<String, dynamic> userData = data['data'];
            final String token = userData['session_token'];
            yield AuthenticatedState(token: token);
          } else {
            final String error = data['error'];
            yield AuthenticationErrorState(error: error);
          }
        } else {
          final Map<String, dynamic> data = json.decode(response.body);
          final String error = data['error'];
          yield AuthenticationErrorState(error: error);
        }
      } catch (e) {
        yield AuthenticationErrorState(
            error: 'Error during authentication ${e.toString()}');
      }
    } else if (event is LogoutEvent) {
      yield UnauthenticatedState();
    }
  }
}
