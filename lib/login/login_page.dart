import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:second_service/auth/bloc/auth_bloc.dart'; // For Google Sign In
import 'package:second_service/forms/user_forms/new_user_form.dart'; // Assuming NewUserForm location

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              SizedBox(height: 50), // Add space before the icon
              Image.asset(
                "assets/icons/app_icon.png",
                height: 100,
              ),
              SizedBox(height: 50), // Add space before the icon

              TextField(
                controller: _emailController, // Assign controller to TextField
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10), // Add spacing between fields
              TextField(
                controller:
                    _passwordController, // Assign controller to TextField
                obscureText: true, // Set obscureText to true for password field
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle forgot password functionality
                },
                child: Text('¿Olvidaste tu contraseña?'),
              ),
              MaterialButton(
                child: Text("Iniciar Sesión"),
                color: Colors.blue, // Assuming blue color for the button
                onPressed: () {
                  final email =
                      _emailController.text; // Get text from email controller
                  final password = _passwordController
                      .text; // Get text from password controller

                  BlocProvider.of<AuthBloc>(context)
                      .add(EmailAuthEvent(email: email, password: password));
                },
              ),
              SignInButton(
                Buttons.Google,
                text: "Iniciar con Google",
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
              ),
              SizedBox(height: 10), // Add spacing between fields
              MaterialButton(
                child: Text("Registrarme"),
                color: Colors.grey, // Assuming blue color for the button
                onPressed: () {
                  // Navigate to NewUserForm
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewUserForm()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
