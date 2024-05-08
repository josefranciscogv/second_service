import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // for @required

class ReservationProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName =
      'reservations'; // Replace with your collection name

  Future<void> createReservation({
    required String title,
    required String date,
    required String description,
    required int fieldNumber,
  }) async {
    try {
      final docRef = _firestore.collection(_collectionName).doc();
      await docRef.set({
        'title': title,
        'start_date': DateTime.parse(
            date), // Assuming date is in a format parsable by DateTime
        'description': description,
        'field_number': fieldNumber,
      });
      print('Reserva creada exitosamente!');
    } on FirebaseException catch (e) {
      print('Error creating reservation: $e');
      // Handle errors appropriately (e.g., show a snackbar)
    } finally {
      notifyListeners();
    }
  }
}
