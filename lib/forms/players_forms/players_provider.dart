import 'dart:io'; // For File type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class PlayersProvider with ChangeNotifier {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPlayer(
      String name, String email, String membership, File image) async {
    try {
      // Generate a unique filename for the image
      final String filename =
          '${name}_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Create a reference to the image storage location
      final storageRef = _storage.ref().child('players/$filename');

      // Upload the image to Firebase Storage
      final uploadTask = storageRef.putFile(image);
      await uploadTask;

      // Get the download URL for the uploaded image
      final imageUrl = await storageRef.getDownloadURL();

      // Create a new player document in Firestore
      final playerDoc = await _firestore.collection('players').add({
        'name': name,
        'email': email,
        'membership': membership,
        'profile_picture': imageUrl,
      });

      print('Player added successfully: ${playerDoc.id}');
    } on FirebaseException catch (e) {
      print('Error adding player: $e');
      // Handle errors appropriately (e.g., show a snackbar to the user)
    }
  }
}
