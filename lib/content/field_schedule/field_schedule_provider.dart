import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:second_service/models/reservation.dart';

class FieldScheduleProvider with ChangeNotifier {
  // Add a list to hold reservations
  List<Reservation> _reservations = [];
  bool _isLoading = false;

  // Getter for reservations
  List<Reservation> get reservations => _reservations;

  // Getter for isLoading
  bool get isLoading => _isLoading;

  // Method to fetch reservations by field number
  Future<void> getAllReservations(int fieldNumber) async {
    _isLoading = true;
    notifyListeners(); // Update loading state before fetching

    try {
      // Get a reference to the reservations collection
      final reservationsCollection =
          FirebaseFirestore.instance.collection('reservations');

      // Query reservations based on field number
      final querySnapshot = await reservationsCollection
          .where('fieldNumber', isEqualTo: fieldNumber)
          .get();

      // Process retrieved documents
      _reservations = querySnapshot.docs
          .map((doc) => Reservation.fromFirestore(
              doc.data() as DocumentSnapshot<Object?>))
          .toList();
    } catch (error) {
      print('Error fetching reservations: $error');
      // Handle errors appropriately (e.g., show error message)
    } finally {
      _isLoading = false;
      notifyListeners(); // Update loading state after fetching
    }
  }
}
