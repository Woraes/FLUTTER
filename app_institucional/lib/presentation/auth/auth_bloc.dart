import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignOut extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    // Simular verificação de autenticação
    await Future.delayed(const Duration(seconds: 1));
    
    // Por enquanto, sempre retorna não autenticado
    emit(AuthUnauthenticated());
  }

  Future<void> _onSignInWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    // Simular delay de login
    await Future.delayed(const Duration(seconds: 1));
    
    // Simular login bem-sucedido para qualquer email/senha
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: 'Usuário Demo',
        email: event.email,
        phone: '',
        type: UserType.citizen,
        status: UserStatus.active,
        createdAt: DateTime.now(),
      );
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthError('Email e senha são obrigatórios'));
    }
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    // Simular delay de logout
    await Future.delayed(const Duration(milliseconds: 500));
    
    emit(AuthUnauthenticated());
  }
}
