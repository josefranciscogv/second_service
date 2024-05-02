import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming you have an AuthBloc for handling authentication state
import '../auth/bloc/auth_bloc.dart';
import '../content/tennis_field/tennis_field.dart';

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
            onPressed: () =>
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent()),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2, // Defines 2 columns in the grid

        children: [
          TennisField(
              image: 'assets/icons/tennis-court-1.png', text: 'Cancha 1'),
          TennisField(
              image: 'assets/icons/tennis-court-2.png', text: 'Cancha 2'),
          TennisField(
              image: 'assets/icons/tennis-court-3.png', text: 'Cancha 3'),
          TennisField(
              image: 'assets/icons/tennis-court-4.png', text: 'Cancha 4'),
        ],
      ),
    );
  }
}
