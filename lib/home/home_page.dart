import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_service/auth/bloc/auth_bloc.dart';
import 'package:second_service/profile/profile_page.dart';
import '../content/tennis_field/tennis_field.dart';
import '../content/field_schedule/field_schedule.dart'; // Assuming field_schedule.dart is in the same directory or adjust the path

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Service'),
        actions: [
          // Add the sign out button to the actions list (optional)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent()),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => navigateToPage(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'home',
                child: Text('Home'),
              ),
              PopupMenuItem(
                value: 'tournaments',
                child: Text('Torunaments'),
              ),
              PopupMenuItem(
                value: 'players',
                child: Text('Players'),
              ),
              PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Defines 2 columns in the grid
              children: [
                GestureDetector(
                  onTap: () => navigateToFieldSchedule(
                      context, 'assets/icons/tennis-court-1.png', 'Cancha 1'),
                  child: TennisField(
                    image: 'assets/icons/tennis-court-1.png',
                    text: 'Cancha 1',
                    onTap: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () => navigateToFieldSchedule(
                      context, 'assets/icons/tennis-court-2.png', 'Cancha 2'),
                  child: TennisField(
                    image: 'assets/icons/tennis-court-2.png',
                    text: 'Cancha 2',
                    onTap: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () => navigateToFieldSchedule(
                      context, 'assets/icons/tennis-court-3.png', 'Cancha 3'),
                  child: TennisField(
                    image: 'assets/icons/tennis-court-3.png',
                    text: 'Cancha 3',
                    onTap: () {},
                  ),
                ),
                GestureDetector(
                  onTap: () => navigateToFieldSchedule(
                      context, 'assets/icons/tennis-court-4.png', 'Cancha 4'),
                  child: TennisField(
                    image: 'assets/icons/tennis-court-4.png',
                    text: 'Cancha 4',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selecciona una cancha',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Adjust color as needed
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToFieldSchedule(
      BuildContext context, String image, String courtName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FieldSchedule(
          image: image, // Pass image path
          exchangeName: courtName, // Pass court name
          // Additional fields for FieldSchedule (optional)
          date: '2024-05-04',
          fieldNumber: int.parse(courtName[courtName.length - 1]),
        ),
      ),
    );
  }

  void navigateToPage(BuildContext context, String page) {
    // Handle navigation based on the selected page value (home, tournaments, etc.)
    // You can use Navigator.push or a custom navigation logic here
    if (page == 'home') {
      // No need to navigate, this is the current page
    } else if (page == 'profile') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      // Implement navigation logic for other pages (tournaments, players)
      // Placeholder for now
      print("Navigating to $page");
    }
  }
}
