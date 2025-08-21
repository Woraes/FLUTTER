import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/config/app_config.dart';

class TrafficPage extends StatefulWidget {
  const TrafficPage({super.key});

  @override
  State<TrafficPage> createState() => _TrafficPageState();
}

class _TrafficPageState extends State<TrafficPage> {
  final List<TrafficInfo> _trafficInfo = [];
  bool _isLoading = false;
  String _selectedRegion = 'Todas';

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    setState(() {
      _isLoading = true;
    });

    // Simular carregamento
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _trafficInfo.clear();
        _trafficInfo.addAll([
          TrafficInfo(
            id: '1',
            region: 'Centro',
            street: 'Av. Presidente Vargas',
            status: TrafficStatus.congestionado,
            description: 'Trânsito lento devido a obras na pista',
            intensity: 8,
            updatedAt: DateTime.now().subtract(const Duration(minutes: 15)),
            estimatedTime: '25 min',
            alternativeRoutes: ['Rua do Ouvidor', 'Rua da Carioca'],
          ),
          TrafficInfo(
            id: '2',
            region: 'Zona Sul',
            street: 'Av. Atlântica',
            status: TrafficStatus.fluindo,
            description: 'Trânsito normal',
            intensity: 2,
            updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
            estimatedTime: '8 min',
            alternativeRoutes: [],
          ),
          TrafficInfo(
            id: '3',
            region: 'Zona Norte',
            street: 'Av. Brasil',
            status: TrafficStatus.parado,
            description: 'Acidente bloqueando duas faixas',
            intensity: 10,
            updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
            estimatedTime: '45 min',
            alternativeRoutes: ['Linha Vermelha', 'Linha Amarela'],
          ),
          TrafficInfo(
            id: '4',
            region: 'Zona Oeste',
            street: 'Av. das Américas',
            status: TrafficStatus.congestionado,
            description: 'Trânsito intenso próximo ao shopping',
            intensity: 7,
            updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
            estimatedTime: '20 min',
            alternativeRoutes: ['Av. Sernambetiba'],
          ),
          TrafficInfo(
            id: '5',
            region: 'Centro',
            street: 'Rua do Mercado',
            status: TrafficStatus.fluindo,
            description: 'Trânsito livre',
            intensity: 1,
            updatedAt: DateTime.now().subtract(const Duration(minutes: 2)),
            estimatedTime: '3 min',
            alternativeRoutes: [],
          ),
        ]);
        _isLoading = false;
      });
    });
  }

  List<TrafficInfo> get _filteredTrafficInfo {
    if (_selectedRegion == 'Todas') {
      return _trafficInfo;
    }
    return _trafficInfo.where((info) => info.region == _selectedRegion).toList();
  }

  Color _getStatusColor(TrafficStatus status) {
    switch (status) {
      case TrafficStatus.fluindo:
        return Colors.green;
      case TrafficStatus.congestionado:
        return Colors.orange;
      case TrafficStatus.parado:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(TrafficStatus status) {
    switch (status) {
      case TrafficStatus.fluindo:
        return Icons.trending_up;
      case TrafficStatus.congestionado:
        return Icons.trending_flat;
      case TrafficStatus.parado:
        return Icons.trending_down;
    }
  }

  String _getStatusText(TrafficStatus status) {
    switch (status) {
      case TrafficStatus.fluindo:
        return 'FLUINDO';
      case TrafficStatus.congestionado:
        return 'CONGESTIONADO';
      case TrafficStatus.parado:
        return 'PARADO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trânsito ao Vivo'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMockData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Estatísticas
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total', _trafficInfo.length.toString(), Icons.traffic),
                ),
                Expanded(
                  child: _buildStatCard('Fluindo', 
                    _trafficInfo.where((t) => t.status == TrafficStatus.fluindo).length.toString(), 
                    Icons.trending_up, Colors.green),
                ),
                Expanded(
                  child: _buildStatCard('Congestionado', 
                    _trafficInfo.where((t) => t.status == TrafficStatus.congestionado).length.toString(), 
                    Icons.trending_flat, Colors.orange),
                ),
                Expanded(
                  child: _buildStatCard('Parado', 
                    _trafficInfo.where((t) => t.status == TrafficStatus.parado).length.toString(), 
                    Icons.trending_down, Colors.red),
                ),
              ],
            ),
          ),

          // Lista de informações de trânsito
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTrafficInfo.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.traffic, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Nenhuma informação de trânsito encontrada',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _filteredTrafficInfo.length,
                        itemBuilder: (context, index) {
                          final trafficInfo = _filteredTrafficInfo[index];
                          return _buildTrafficCard(trafficInfo);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, [Color? color]) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Icon(icon, color: color ?? AppConfig.primaryColor, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrafficCard(TrafficInfo trafficInfo) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(trafficInfo.status),
          child: Icon(
            _getStatusIcon(trafficInfo.status),
            color: Colors.white,
          ),
        ),
        title: Text(
          trafficInfo.street,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trafficInfo.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(trafficInfo.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(trafficInfo.status),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${trafficInfo.intensity}/10',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${DateFormat('HH:mm').format(trafficInfo.updatedAt)} • ${trafficInfo.region} • Tempo estimado: ${trafficInfo.estimatedTime}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleTrafficAction(value, trafficInfo),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility),
                  SizedBox(width: 8),
                  Text('Ver Detalhes'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'route',
              child: Row(
                children: [
                  Icon(Icons.route),
                  SizedBox(width: 8),
                  Text('Rotas Alternativas'),
                ],
              ),
            ),
          ],
        ),
        onTap: () => _showTrafficDetails(trafficInfo),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar por Região'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Todas',
            'Centro',
            'Zona Sul',
            'Zona Norte',
            'Zona Oeste',
          ].map((region) => RadioListTile<String>(
            title: Text(region),
            value: region,
            groupValue: _selectedRegion,
            onChanged: (value) {
              setState(() {
                _selectedRegion = value!;
              });
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showTrafficDetails(TrafficInfo trafficInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(trafficInfo.street),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('**Região:** ${trafficInfo.region}'),
              const SizedBox(height: 8),
              Text('**Status:** ${_getStatusText(trafficInfo.status)}'),
              const SizedBox(height: 8),
              Text('**Intensidade:** ${trafficInfo.intensity}/10'),
              const SizedBox(height: 8),
              Text('**Descrição:** ${trafficInfo.description}'),
              const SizedBox(height: 8),
              Text('**Tempo Estimado:** ${trafficInfo.estimatedTime}'),
              const SizedBox(height: 8),
              Text('**Atualizado:** ${DateFormat('dd/MM/yyyy HH:mm').format(trafficInfo.updatedAt)}'),
              if (trafficInfo.alternativeRoutes.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text('**Rotas Alternativas:**'),
                ...trafficInfo.alternativeRoutes.map((route) => 
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 4),
                    child: Text('• $route'),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _handleTrafficAction(String action, TrafficInfo trafficInfo) {
    switch (action) {
      case 'view':
        _showTrafficDetails(trafficInfo);
        break;
      case 'route':
        _showAlternativeRoutes(trafficInfo);
        break;
    }
  }

  void _showAlternativeRoutes(TrafficInfo trafficInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rotas Alternativas'),
        content: trafficInfo.alternativeRoutes.isEmpty
            ? const Text('Nenhuma rota alternativa disponível.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Para ${trafficInfo.street}:'),
                  const SizedBox(height: 16),
                  ...trafficInfo.alternativeRoutes.map((route) => 
                    ListTile(
                      leading: const Icon(Icons.route),
                      title: Text(route),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Rota $route selecionada')),
                        );
                      },
                    ),
                  ),
                ],
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

enum TrafficStatus { fluindo, congestionado, parado }

class TrafficInfo {
  final String id;
  final String region;
  final String street;
  final TrafficStatus status;
  final String description;
  final int intensity;
  final DateTime updatedAt;
  final String estimatedTime;
  final List<String> alternativeRoutes;

  TrafficInfo({
    required this.id,
    required this.region,
    required this.street,
    required this.status,
    required this.description,
    required this.intensity,
    required this.updatedAt,
    required this.estimatedTime,
    required this.alternativeRoutes,
  });
}
