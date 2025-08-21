import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'presentation/auth/auth_bloc.dart';
import 'presentation/citizen/citizen_home_page.dart';
import 'presentation/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AppInstitucional());
}

class AppInstitucional extends StatelessWidget {
  const AppInstitucional({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'App Institucional - Itaguaí',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          // Verificar se é um munícipe
          if (state.user.isCitizen) {
            return CitizenHomePage(user: state.user);
          }
          // Para agentes e admins, usar a página geral (a ser implementada)
          return CitizenHomePage(user: state.user);
        }

        return const LoginPage();
      },
    );
  }
}
