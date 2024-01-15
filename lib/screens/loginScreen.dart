import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_session_app/screens/homeScreen.dart';
import '../shared/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          // Handle successful authentication, e.g., navigate to the home screen
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (state is AuthenticationErrorState) {
          // Handle authentication error, show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller:
                      usernameController, // Menggunakan controller yang ada di dalam LoginForm
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller:
                      passwordController, // Menggunakan controller yang ada di dalam LoginForm
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final String username = usernameController.text;
                    final String password = passwordController.text;
                    authBloc.add(LoginEvent(
                      username: username,
                      password: password,
                    ));
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
