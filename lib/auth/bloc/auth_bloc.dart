import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:second_service/auth/user_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerfication);
    on<AnonymousAuthEvent>(_authAnonymous);
    on<GoogleAuthEvent>(_authUser);
    on<SignOutEvent>(_signOut);
    // Added event handler for sign in with email
    on<EmailAuthEvent>(_authWithEmail);
  }

  FutureOr<void> _authVerfication(event, emit) {
    // Check if user is already authenticated
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    // Sign out user
    await _authRepo.signOutGoogleUser();
    await _authRepo.signOutFirebaseUser();
    emit(SignOutSuccessState());
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(AuthAwaitingState());
    try {
      // Sign in user with Google
      await _authRepo.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      print("Error al autenticar: $e");
      print(e.toString());
      emit(AuthErrorState());
    }
  }

  FutureOr<void> _authAnonymous(event, emit) async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  // Added method for handling sign in with email
  FutureOr<void> _authWithEmail(EmailAuthEvent event, emit) async {
    emit(AuthAwaitingState());
    try {
      // Sign in user with email and password from the event
      await _authRepo.signInWithEmailAndPassword(event.email, event.password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      // Handle specific exceptions like user-not-found or wrong-password
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(message: 'Wrong password provided.'));
      } else {
        emit(AuthErrorState(message: e.code)); // Handle other errors
      }
    } catch (e) {
      // Catch any other unexpected errors
      print("Error al autenticar: $e");
      print(e.toString());
      emit(AuthErrorState());
    }
  }
}
