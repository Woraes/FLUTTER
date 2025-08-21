import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/config/app_config.dart';
import '../../data/models/user_model.dart';
import '../../data/models/citizen_features.dart';
import '../auth/auth_bloc.dart';
import 'panic_button_page.dart';
import 'occurrences_page.dart';
import 'population_channel_page.dart';
import 'citizen_profile_page.dart';

class CitizenHomePage extends StatefulWidget {
  final User user;

  const CitizenHomePage({super.key, required this.user});

  @override
  State<CitizenHomePage> createState() => _CitizenHomePageState();
}

class _CitizenHomePageState extends State<CitizenHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const CitizenDashboardTab(),
      const CitizenOccurrencesPage(),
      const PopulationChannelPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cidadão - Itaguaí'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitizenProfilePage(user: widget.user),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notificações em desenvolvimento'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOut());
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppConfig.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.traffic),
            label: 'Trânsito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Canal',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PanicButtonPage(user: widget.user),
            ),
          );
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.emergency),
        label: const Text('PÂNICO'),
      ),
    );
  }
}

class CitizenDashboardTab extends StatefulWidget {
  const CitizenDashboardTab({super.key});

  @override
  State<CitizenDashboardTab> createState() => _CitizenDashboardTabState();
}

class _CitizenDashboardTabState extends State<CitizenDashboardTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com informações do usuário
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppConfig.primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bem-vindo, Cidadão!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppConfig.primaryColor,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Como podemos ajudá-lo hoje?',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Funcionalidades principais
          Text(
            'Funcionalidades Principais',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          // Botão do Pânico
          _buildFeatureCard(
            context,
            icon: Icons.emergency,
            title: 'Botão do Pânico',
            subtitle: 'Para vítimas de violência ou situações de emergência',
            description:
                'Envia localização em tempo real para a Central de Monitoramento',
            color: Colors.red,
            onTap: () {
              // Navegar para o botão do pânico
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PanicButtonPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Ocorrências de Trânsito
          _buildFeatureCard(
            context,
            icon: Icons.traffic,
            title: 'Ocorrências de Trânsito',
            subtitle:
                'Reporte acidentes, semáforos quebrados, buracos na via e outros problemas de trânsito',
            description:
                'Anexe fotos, vídeos e sua localização atual. Acompanhe o status em tempo real.',
            color: AppConfig.primaryColor,
            onTap: () {
              // Navegar para a página de ocorrências
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CitizenOccurrencesPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Canal da População
          _buildFeatureCard(
            context,
            icon: Icons.people,
            title: 'Canal da População',
            subtitle: 'Canal direto de comunicação com a população',
            description:
                'Denúncias anônimas, sugestões, reclamações e participação em pesquisas públicas',
            color: AppConfig.secondaryColor,
            onTap: () {
              // Navegar para o canal da população
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PopulationChannelPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Informações da Prefeitura
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: AppConfig.primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Prefeitura de Itaguaí',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppConfig.primaryColor,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Secretaria de Segurança Pública, Defesa Civil e Trânsito',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Notificação instantânea para a Central de Monitoramento',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
