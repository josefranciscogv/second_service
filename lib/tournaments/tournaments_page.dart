import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class TournamentsPage extends StatefulWidget {
  @override
  _TournamentsPageState createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  @override
  Widget build(BuildContext context) {
    final tournamentsQuery = FirebaseFirestore.instance
        .collection('tournaments'); // Replace with your collection name

    return Scaffold(
      appBar: AppBar(
        title: Text('Torneos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tournamentsQuery.snapshots(), // Stream for real-time updates
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return FirestoreListView<Map<String, dynamic>>(
            query: tournamentsQuery,
            itemBuilder: (context, snapshot) {
              final tournament = snapshot.data();
              final tournamentName =
                  tournament['title']; // Assuming 'name' field

              return Card(
                child: ListTile(
                  title: Text(
                      tournamentName ?? 'Sin Nombre'), // Handle missing name
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to NewReservationForm
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
