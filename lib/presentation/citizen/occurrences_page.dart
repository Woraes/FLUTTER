import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/config/app_config.dart';
import '../../data/models/citizen_features.dart';

class CitizenOccurrencesPage extends StatefulWidget {
  const CitizenOccurrencesPage({super.key});

  @override
  State<CitizenOccurrencesPage> createState() => _CitizenOccurrencesPageState();
}

class _CitizenOccurrencesPageState extends State<CitizenOccurrencesPage> {
  List<CitizenOccurrence> _occurrences = [];
  List<TrafficAgentReport> _agentReports = [];
  bool _isLoading = true;
  String _selectedFilter = 'Todas';
  int _selectedTabIndex = 0;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() async {
    // Simular carregamento
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _occurrences = [
        CitizenOccurrence(
          id: '1',
          title: 'Acidente de trânsito',
          description: 'Colisão entre dois veículos na Rua das Flores',
          type: OccurrenceType.accident,
          status: OccurrenceStatus.resolved,
          priority: OccurrencePriority.high,
          citizenId: '1',
          latitude: -22.8523,
          longitude: -43.7764,
          address: 'Rua das Flores, 123 - Itaguaí',
          protocol: 'OC001/2024',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          resolvedAt: DateTime.now().subtract(const Duration(hours: 6)),
        ),
        CitizenOccurrence(
          id: '2',
          title: 'Semáforo quebrado',
          description: 'Semáforo não está funcionando na esquina da Rua da Paz',
          type: OccurrenceType.brokenSignal,
          status: OccurrenceStatus.inProgress,
          priority: OccurrencePriority.normal,
          citizenId: '1',
          latitude: -22.8525,
          longitude: -43.7766,
          address: 'Rua da Paz, 456 - Itaguaí',
          protocol: 'OC002/2024',
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        CitizenOccurrence(
          id: '3',
          title: 'Buraco na via',
          description: 'Buraco grande na pista da Avenida Principal',
          type: OccurrenceType.pothole,
          status: OccurrenceStatus.pending,
          priority: OccurrencePriority.high,
          citizenId: '1',
          latitude: -22.8520,
          longitude: -43.7760,
          address: 'Avenida Principal, 789 - Itaguaí',
          protocol: 'OC003/2024',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ];

      _agentReports = [
        TrafficAgentReport(
          id: '1',
          agentName: 'João Silva',
          agentBadge: 'AT001',
          description: 'Veículo estacionado em local proibido',
          type: 'traffic_violation',
          latitude: -22.8523,
          longitude: -43.7764,
          address: 'Rua das Flores, 123 - Itaguaí',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          vehiclePlate: 'ABC-1234',
          violationType: 'Estacionamento Irregular',
        ),
        TrafficAgentReport(
          id: '2',
          agentName: 'Maria Santos',
          agentBadge: 'AT002',
          description: 'Congestionamento na Avenida Principal',
          type: 'congestion',
          latitude: -22.8520,
          longitude: -43.7760,
          address: 'Avenida Principal, 789 - Itaguaí',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        TrafficAgentReport(
          id: '3',
          agentName: 'Pedro Costa',
          agentBadge: 'AT003',
          description: 'Acidente envolvendo moto e carro',
          type: 'accident',
          latitude: -22.8525,
          longitude: -43.7766,
          address: 'Rua da Paz, 456 - Itaguaí',
          createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
          vehiclePlate: 'XYZ-5678',
        ),
      ];
      _isLoading = false;
    });
  }

  List<CitizenOccurrence> get _filteredOccurrences {
    if (_selectedFilter == 'Todas') {
      return _occurrences;
    }
    return _occurrences
        .where((oc) => oc.statusDisplayName == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header com título e abas
          Container(
            padding: const EdgeInsets.all(16),
            color: AppConfig.primaryColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.traffic,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Trânsito',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Abas
                Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        title: 'Minhas Ocorrências',
                        icon: Icons.report,
                        isSelected: _selectedTabIndex == 0,
                        onTap: () => setState(() => _selectedTabIndex = 0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTabButton(
                        title: 'Mapa',
                        icon: Icons.map,
                        isSelected: _selectedTabIndex == 1,
                        onTap: () => setState(() => _selectedTabIndex = 1),
                      ),
                    ),
                  ],
                ),
                // Filtros (apenas para a aba de ocorrências)
                if (_selectedTabIndex == 0) ...[
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Todas'),
                        _buildFilterChip('Pendente'),
                        _buildFilterChip('Em Andamento'),
                        _buildFilterChip('Resolvida'),
                        _buildFilterChip('Cancelada'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Conteúdo das abas
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _selectedTabIndex == 0
                    ? _buildOccurrencesTab()
                    : _buildMapTab(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showNewOccurrenceDialog();
        },
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nova Ocorrência de Trânsito'),
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppConfig.primaryColor : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppConfig.primaryColor : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppConfig.primaryColor : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = label;
          });
        },
        backgroundColor: Colors.transparent,
        selectedColor: Colors.white,
        checkmarkColor: AppConfig.primaryColor,
        side: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildOccurrencesTab() {
    return _filteredOccurrences.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredOccurrences.length,
            itemBuilder: (context, index) {
              final occurrence = _filteredOccurrences[index];
              return _buildOccurrenceCard(occurrence);
            },
          );
  }

  Widget _buildMapTab() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-22.8523, -43.7764), // Itaguaí
            zoom: 13,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          markers: _buildMapMarkers(),
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
                  Text(
                    'Legenda',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendItem(Icons.report, 'Minhas Ocorrências',
                      AppConfig.primaryColor),
                  _buildLegendItem(Icons.local_police, 'Infração', Colors.red),
                  _buildLegendItem(Icons.car_crash, 'Acidente', Colors.orange),
                  _buildLegendItem(
                      Icons.traffic, 'Congestionamento', Colors.yellow),
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
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Set<Marker> _buildMapMarkers() {
    final Set<Marker> markers = {};

    // Marcadores das ocorrências do usuário
    for (final occurrence in _filteredOccurrences) {
      if (occurrence.latitude != null && occurrence.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId('occurrence_${occurrence.id}'),
            position: LatLng(occurrence.latitude!, occurrence.longitude!),
            infoWindow: InfoWindow(
              title: occurrence.title,
              snippet: occurrence.description,
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      }
    }

    // Marcadores dos agentes de trânsito
    for (final report in _agentReports) {
      markers.add(
        Marker(
          markerId: MarkerId('agent_${report.id}'),
          position: LatLng(report.latitude, report.longitude),
          infoWindow: InfoWindow(
            title: '${report.typeDisplayName} - ${report.agentName}',
            snippet: report.description,
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(_getMarkerHue(report.type)),
        ),
      );
    }

    return markers;
  }

  double _getMarkerHue(String type) {
    switch (type) {
      case 'traffic_violation':
        return BitmapDescriptor.hueRed;
      case 'accident':
        return BitmapDescriptor.hueOrange;
      case 'congestion':
        return BitmapDescriptor.hueYellow;
      case 'maintenance':
        return BitmapDescriptor.hueBlue;
      default:
        return BitmapDescriptor.hueGreen;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma ocorrência de trânsito encontrada',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no botão + para criar uma nova ocorrência',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccurrenceCard(CitizenOccurrence occurrence) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showOccurrenceDetails(occurrence),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: occurrence.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getOccurrenceIcon(occurrence.type),
                      color: occurrence.statusColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          occurrence.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Protocolo: ${occurrence.protocol}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: occurrence.statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      occurrence.statusDisplayName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                occurrence.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      occurrence.address ?? 'Localização não informada',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(occurrence.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const Spacer(),
                  if (occurrence.attachments.isNotEmpty) ...[
                    Icon(
                      Icons.attach_file,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${occurrence.attachments.length} anexo(s)',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getOccurrenceIcon(OccurrenceType type) {
    switch (type) {
      case OccurrenceType.accident:
        return Icons.car_crash;
      case OccurrenceType.trafficJam:
        return Icons.traffic;
      case OccurrenceType.brokenSignal:
        return Icons.traffic;
      case OccurrenceType.pothole:
        return Icons.construction;
      case OccurrenceType.illegalParking:
        return Icons.local_parking;
      case OccurrenceType.speeding:
        return Icons.speed;
      case OccurrenceType.drunkDriving:
        return Icons.no_drinks;
      case OccurrenceType.other:
        return Icons.report;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} dia(s) atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hora(s) atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minuto(s) atrás';
    } else {
      return 'Agora mesmo';
    }
  }

  void _showOccurrenceDetails(CitizenOccurrence occurrence) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(occurrence.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Protocolo: ${occurrence.protocol}'),
              const SizedBox(height: 8),
              Text('Descrição: ${occurrence.description}'),
              const SizedBox(height: 8),
              Text('Tipo: ${occurrence.typeDisplayName}'),
              const SizedBox(height: 8),
              Text('Status: ${occurrence.statusDisplayName}'),
              const SizedBox(height: 8),
              Text('Prioridade: ${occurrence.priority.name}'),
              const SizedBox(height: 8),
              Text('Endereço: ${occurrence.address ?? 'Não informado'}'),
              const SizedBox(height: 8),
              Text('Data: ${_formatDate(occurrence.createdAt)}'),
              if (occurrence.resolvedAt != null) ...[
                const SizedBox(height: 8),
                Text('Resolvida em: ${_formatDate(occurrence.resolvedAt!)}'),
              ],
            ],
          ),
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

  void _showNewOccurrenceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Ocorrência de Trânsito'),
        content: const Text(
            'Funcionalidade em desenvolvimento. Em breve você poderá reportar problemas de trânsito diretamente pelo app.'),
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
