import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  // True -> go home page
  // False -> go login page
  bool isAlreadyAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> signOutGoogleUser() async {
    // Google user signout
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebaseUser() async {
    // Firebase user signout
    await _auth.signOut();
  }

  Future<void> signInWithGoogle() async {
    // Set up Google sign in
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return; // User might cancel sign in flow

    final googleAuth = await googleUser.authentication;

    print(">> User email: ${googleUser.email}");
    print(">> User display name: ${googleUser.displayName}");
    print(">> User photo url: ${googleUser.photoUrl}");

    // Get credentials of authenticated user with Google
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Firebase sign in with Google credentials
    await _auth.signInWithCredential(credential);
  }

  // Added method for sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code); // Print other errors
      }
    }
  }
}
