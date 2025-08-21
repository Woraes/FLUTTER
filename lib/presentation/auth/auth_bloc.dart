import 'dart:async';
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

class SignUp extends AuthEvent {
  final String nome;
  final String email;
  final String senha;
  final String? cpf;
  final String? telefone;

  const SignUp({
    required this.nome,
    required this.email,
    required this.senha,
    this.cpf,
    this.telefone,
  });

  @override
  List<Object?> get props => [nome, email, senha, cpf, telefone];
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
  final String token;

  const AuthAuthenticated(this.user, this.token);

  @override
  List<Object?> get props => [user, token];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignUp>(_onSignUp);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Verificar se há token salvo no SharedPreferences
      // Por enquanto, vamos simular que não há autenticação
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Erro ao verificar status de autenticação: $e'));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simular login via API
      await Future.delayed(const Duration(seconds: 2));
      
      // Criar usuário simulado
      final user = User(
        id: '1',
        name: 'João Silva',
        email: event.email,
        cpf: '123.456.789-00',
        phone: '(11) 99999-9999',
        type: UserType.citizen,
        status: UserStatus.active,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        permissions: {'permissions': ['report_occurrence', 'anonymous_report', 'view_own_reports', 'submit_feedback']},
        isVerified: true,
      );
      
      const token = 'mock_jwt_token_citizen';
      
      emit(AuthAuthenticated(user, token));
    } catch (e) {
      emit(AuthError('Erro no login: $e'));
    }
  }

  Future<void> _onSignUp(
    SignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simular registro via API
      await Future.delayed(const Duration(seconds: 2));
      
      // Criar usuário simulado
      final user = User(
        id: '2',
        name: event.nome,
        email: event.email,
        cpf: event.cpf,
        phone: event.telefone,
        type: UserType.citizen,
        status: UserStatus.active,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        permissions: {'permissions': ['report_occurrence', 'anonymous_report', 'view_own_reports', 'submit_feedback']},
        isVerified: false,
      );
      
      const token = 'mock_jwt_token_new_citizen';
      
      emit(AuthAuthenticated(user, token));
    } catch (e) {
      emit(AuthError('Erro no registro: $e'));
    }
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Simular logout
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Erro no logout: $e'));
    }
  }
}
