import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:second_service/auth/bloc/auth_bloc.dart'; // For Google Sign In

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
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
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10), // Add spacing between fields
              TextField(
                obscureText: true, // Set obscureText to true for password field
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle forgot password functionality
                },
                child: Text('Forgot password?'),
              ),
              MaterialButton(
                child: Text("Sign In"),
                color: Colors.blue, // Assuming blue color for the button
                onPressed: () {
                  // Handle sign in logic
                },
              ),
              SignInButton(
                Buttons.Google,
                text: "Iniciar con Google",
                onPressed: () async {
                  BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
