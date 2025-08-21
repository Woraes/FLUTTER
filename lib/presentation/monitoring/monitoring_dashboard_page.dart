import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/config/app_config.dart';
import '../../data/models/user_model.dart';

class MonitoringDashboardPage extends StatefulWidget {
  final User user;
  const MonitoringDashboardPage({super.key, required this.user});

  @override
  State<MonitoringDashboardPage> createState() => _MonitoringDashboardPageState();
}

class _MonitoringDashboardPageState extends State<MonitoringDashboardPage> {
  bool _isSidebarCollapsed = false;
  int _selectedMenuItem = 0;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMapMarkers();
  }

  void _loadMapMarkers() {
    // Marcadores mock para demonstração
    _markers = {
      // Emergências (vermelho)
      Marker(
        markerId: const MarkerId('emergency_1'),
        position: const LatLng(-22.8523, -43.7764),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Emergência - Acidente',
          snippet: 'Acidente na BR-101, km 45',
        ),
      ),
      // Trânsito (laranja)
      Marker(
        markerId: const MarkerId('traffic_1'),
        position: const LatLng(-22.8525, -43.7766),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(
          title: 'Trânsito - Congestionamento',
          snippet: 'Congestionamento na Rodovia Rio-Santos',
        ),
      ),
      // Segurança (azul)
      Marker(
        markerId: const MarkerId('security_1'),
        position: const LatLng(-22.8520, -43.7760),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'Segurança - Patrulha',
          snippet: 'Viatura em patrulha - Centro',
        ),
      ),
      // Defesa Civil (verde)
      Marker(
        markerId: const MarkerId('civil_defense_1'),
        position: const LatLng(-22.8528, -43.7768),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'Defesa Civil - Alagamento',
          snippet: 'Alagamento na Rua das Flores',
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(),
          // Conteúdo principal
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: _isSidebarCollapsed ? 80 : 280,
      color: AppConfig.primaryColor,
      child: Column(
        children: [
          // Header do sistema
          _buildSystemHeader(),
          // Botão do pânico
          _buildPanicButton(),
          // Menu de navegação
          Expanded(
            child: _buildNavigationMenu(),
          ),
          // Status do sistema
          _buildSystemStatus(),
        ],
      ),
    );
  }

  Widget _buildSystemHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'PI',
                    style: TextStyle(
                      color: AppConfig.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              if (!_isSidebarCollapsed) ...[
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sistema Itaguaí',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Segurança Pública',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              IconButton(
                icon: Icon(
                  _isSidebarCollapsed ? Icons.chevron_right : Icons.chevron_left,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isSidebarCollapsed = !_isSidebarCollapsed;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPanicButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red, size: 20),
                if (!_isSidebarCollapsed) ...[
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Botão do Pânico',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                                                 Text(
                           'Toque para emergência',
                           style: const TextStyle(
                             color: Color(0xB3F44336),
                             fontSize: 10,
                           ),
                         ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showEmergencyDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _isSidebarCollapsed ? '!' : 'EMERGÊNCIA',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu() {
    final menuItems = [
      {'icon': Icons.dashboard, 'label': 'Dashboard', 'count': null},
      {'icon': Icons.map, 'label': 'Mapa Geral', 'count': null},
      {'icon': Icons.warning, 'label': 'Emergências', 'count': 5},
      {'icon': Icons.traffic, 'label': 'Trânsito', 'count': 12},
      {'icon': Icons.security, 'label': 'Segurança', 'count': null},
      {'icon': Icons.flash_on, 'label': 'Defesa Civil', 'count': 2},
      {'icon': Icons.headset_mic, 'label': 'Ouvidoria', 'count': null},
      {'icon': Icons.people, 'label': 'Equipes', 'count': null},
      {'icon': Icons.assessment, 'label': 'Relatórios', 'count': null},
      {'icon': Icons.settings, 'label': 'Configurações', 'count': null},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isSelected = _selectedMenuItem == index;
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            leading: Icon(
              item['icon'] as IconData,
              color: isSelected ? AppConfig.primaryColor : Colors.white70,
            ),
            title: _isSidebarCollapsed
                ? null
                : Text(
                    item['label'] as String,
                    style: TextStyle(
                      color: isSelected ? AppConfig.primaryColor : Colors.white,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
            trailing: _isSidebarCollapsed
                ? null
                : item['count'] != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['count'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
            selected: isSelected,
            selectedTileColor: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              setState(() {
                _selectedMenuItem = index;
              });
              _handleMenuSelection(index);
            },
          ),
        );
      },
    );
  }

  Widget _buildSystemStatus() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi, color: Colors.green, size: 20),
          if (!_isSidebarCollapsed) ...[
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sistema Online',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                                     Text(
                     'Todas as funcionalidades ativas',
                     style: const TextStyle(
                       color: Color(0xB34CAF50),
                       fontSize: 10,
                     ),
                   ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        // Header principal
        _buildMainHeader(),
        // Conteúdo do mapa
        Expanded(
          child: _buildMapContent(),
        ),
      ],
    );
  }

  Widget _buildMainHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prefeitura de Itaguaí - Segurança Pública',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.primaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Sistema de Monitoramento Geral',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Ativo',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Notificações
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  _showNotifications();
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Perfil do usuário
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              _showUserProfile();
            },
          ),
          // Menu de opções
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapContent() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-22.8523, -43.7764), // Itaguaí
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          markers: _markers,
          zoomControlsEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
        // Legenda do mapa
        Positioned(
          top: 16,
          right: 16,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Legenda',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendItem(Icons.warning, 'Emergências', Colors.red),
                  _buildLegendItem(Icons.traffic, 'Trânsito', Colors.orange),
                  _buildLegendItem(Icons.security, 'Segurança', Colors.blue),
                  _buildLegendItem(Icons.flash_on, 'Defesa Civil', Colors.green),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(int index) {
    // Implementar navegação para diferentes seções
    switch (index) {
      case 0: // Dashboard
        break;
      case 1: // Mapa Geral
        break;
      case 2: // Emergências
        _showEmergencies();
        break;
      case 3: // Trânsito
        _showTraffic();
        break;
      case 4: // Segurança
        _showSecurity();
        break;
      case 5: // Defesa Civil
        _showCivilDefense();
        break;
      case 6: // Ouvidoria
        _showOmbudsman();
        break;
      case 7: // Equipes
        _showTeams();
        break;
      case 8: // Relatórios
        _showReports();
        break;
      case 9: // Configurações
        _showSettings();
        break;
    }
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🚨 EMERGÊNCIA'),
        content: const Text(
          'Sistema de emergência ativado!\n\n'
          'Todas as equipes foram notificadas.\n'
          'Coordenadas enviadas para o centro de comando.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notificações'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Nova emergência registrada'),
            Text('• Equipe de trânsito chegou ao local'),
            Text('• Relatório de segurança disponível'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showUserProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perfil do Usuário'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${widget.user.name}'),
            Text('Email: ${widget.user.email}'),
            Text('Tipo: ${widget.user.type.name}'),
            Text('Status: ${widget.user.status.name}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Opções'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showEmergencies() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergências Ativas'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Acidente na BR-101'),
              subtitle: Text('Há 5 minutos'),
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Incêndio no Centro'),
              subtitle: Text('Há 12 minutos'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showTraffic() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Situação do Trânsito'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.traffic, color: Colors.orange),
              title: Text('Congestionamento - BR-101'),
              subtitle: Text('2 km de extensão'),
            ),
            ListTile(
              leading: Icon(Icons.traffic, color: Colors.orange),
              title: Text('Semáforo quebrado - Centro'),
              subtitle: Text('Em manutenção'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showSecurity() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Segurança'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCivilDefense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Defesa Civil'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.flash_on, color: Colors.green),
              title: Text('Alagamento - Rua das Flores'),
              subtitle: Text('Equipe no local'),
            ),
            ListTile(
              leading: Icon(Icons.flash_on, color: Colors.green),
              title: Text('Deslizamento - Morro do Céu'),
              subtitle: Text('Área isolada'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showOmbudsman() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ouvidoria'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTeams() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Equipes'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showReports() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Relatórios'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configurações'),
        content: const Text('Funcionalidade em desenvolvimento'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
