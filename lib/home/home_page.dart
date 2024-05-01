import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming you have an AuthBloc for handling authentication state
import '../auth/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Service'),
        actions: [
          // Add the sign out button to the actions list
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
