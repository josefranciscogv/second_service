import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String id;
  final String title; // New field
  final String date; // New field
  final int fieldNumber;
  final String description; // New field

  Reservation({
    required this.id,
    required this.title, // Required
    required this.date, // Required
    required this.fieldNumber,
    required this.description, // Required
  });

  // Factory method to create Reservation from Firestore document data
  static Reservation fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Reservation(
      id: snapshot.id,
      title:
          data['title'] ?? '', // Handle potential missing field (empty string)
      date: data['start_date'] ??
          '', // Handle potential missing field (empty string)
      fieldNumber: data['field_number'] ??
          0, // Assuming 'fieldNumber' is an integer field
      description: data['description'] ??
          '', // Handle potential missing field (empty string)
    );
  }
}
