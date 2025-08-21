import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'presentation/auth/auth_bloc.dart';
import 'presentation/citizen/citizen_home_page.dart';
import 'presentation/monitoring/monitoring_dashboard_page.dart';
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
          // Detectar plataforma e tipo de usuário
          if (kIsWeb) {
            // WEB: Sempre mostra dashboard de monitoramento
            return MonitoringDashboardPage(user: state.user);
          } else {
            // MOBILE: Mostra interface baseada no tipo de usuário
            if (state.user.isCitizen) {
              return CitizenHomePage(user: state.user);
            } else {
              // Para agentes no mobile, também mostra dashboard de monitoramento
              return MonitoringDashboardPage(user: state.user);
            }
          }
        }

        return const LoginPage();
      },
    );
  }
}
