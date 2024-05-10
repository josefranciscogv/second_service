import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_service/forms/players_forms/new_player_form.dart';

// Assuming you have a Player model or similar to represent player data

class PlayersPage extends StatefulWidget {
  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  Widget build(BuildContext context) {
    final playersQuery =
        FirebaseFirestore.instance // Replace with your collection name
            .collection('players');

    return Scaffold(
      appBar: AppBar(
        title: Text('Jugadores'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: playersQuery.snapshots(), // Stream for real-time updates
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // final players = snapshot.data!.docs
          //     .map((doc) => doc.data())
          //     .toList(); // Convert to list

          return FirestoreListView<Map<String, dynamic>>(
            query: playersQuery,
            itemBuilder: (context, snapshot) {
              final player = snapshot.data();

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: player['picture'] != null
                        ? NetworkImage(player['picture'])
                        : null, // Don't provide an image provider
                    child: player['picture'] == null
                        ? Icon(Icons.person)
                        : null, // Placeholder widget
                  ),
                  title: Text(player['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(player['email']),
                      Text(player['membership'] ??
                          'No membership'), // Handle null membership
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to NewReservationForm
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPlayerForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
