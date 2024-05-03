import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email, String password) async {
    try {
      final userCollection = _firestore.collection('users');
      await userCollection.add({
        'name': name,
        'email': email,
        'password': password, // Store hashed password
      });
      notifyListeners(); // Notify listeners of a change (if using Provider)
    } catch (error) {
      print('Error adding user: $error');
      // Handle errors appropriately (e.g., show a snackbar to the user)
    }
  }
}
