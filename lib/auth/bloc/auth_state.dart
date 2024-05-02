part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {}

class UnAuthState extends AuthState {}

class SignOutSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String? message;

  const AuthErrorState({this.message});

  @override
  List<Object> get props => [message!]; // Make message non-nullable here
}

class AuthAwaitingState extends AuthState {}
