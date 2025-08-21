import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/config/app_config.dart';
import '../../data/models/ocorrencia_model.dart';

class OccurrencesPage extends StatefulWidget {
  const OccurrencesPage({super.key});

  @override
  State<OccurrencesPage> createState() => _OccurrencesPageState();
}

class _OccurrencesPageState extends State<OccurrencesPage> {
  final List<Ocorrencia> _ocorrencias = [];
  bool _isLoading = false;
  String _filterStatus = 'Todas';

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
        _ocorrencias.clear();
        _ocorrencias.addAll([
          Ocorrencia(
            id: '1',
            titulo: 'Acidente de Trânsito',
            descricao: 'Colisão entre dois veículos na Av. Principal',
            tipo: OcorrenciaTipo.acidente,
            status: OcorrenciaStatus.emAndamento,
            prioridade: OcorrenciaPrioridade.alta,
            endereco: 'Av. Principal, 123 - Centro',
            latitude: -22.9068,
            longitude: -43.1729,
            userId: 'user_1',
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
            updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
            fotos: ['foto1.jpg', 'foto2.jpg'],
            metadata: {
              'solicitanteNome': 'João Silva',
              'solicitanteTelefone': '(21) 99999-9999',
              'observacoes': 'Veículos bloqueando o trânsito',
            },
          ),
          Ocorrencia(
            id: '2',
            titulo: 'Assalto a Pedestres',
            descricao: 'Roubo de celular na região do shopping',
            tipo: OcorrenciaTipo.crime,
            status: OcorrenciaStatus.concluida,
            prioridade: OcorrenciaPrioridade.alta,
            endereco: 'Rua do Shopping, 456 - Centro',
            latitude: -22.9068,
            longitude: -43.1729,
            userId: 'user_2',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
            updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
            fotos: ['foto3.jpg'],
            metadata: {
              'solicitanteNome': 'Maria Santos',
              'solicitanteTelefone': '(21) 88888-8888',
              'observacoes': 'Suspeito foi identificado e preso',
            },
          ),
          Ocorrencia(
            id: '3',
            titulo: 'Incêndio em Residência',
            descricao: 'Fogo em apartamento do 3º andar',
            tipo: OcorrenciaTipo.incendio,
            status: OcorrenciaStatus.pendente,
            prioridade: OcorrenciaPrioridade.emergencia,
            endereco: 'Rua das Flores, 789 - Bairro',
            latitude: -22.9068,
            longitude: -43.1729,
            userId: 'user_3',
            createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
            updatedAt: DateTime.now().subtract(const Duration(minutes: 45)),
            fotos: ['foto4.jpg', 'foto5.jpg'],
            metadata: {
              'solicitanteNome': 'Pedro Costa',
              'solicitanteTelefone': '(21) 77777-7777',
              'observacoes': 'Bombeiros já foram acionados',
            },
          ),
          Ocorrencia(
            id: '4',
            titulo: 'Vandalismo em Escola',
            descricao: 'Pichação e quebra de vidros na escola municipal',
            tipo: OcorrenciaTipo.crime,
            status: OcorrenciaStatus.pendente,
            prioridade: OcorrenciaPrioridade.media,
            endereco: 'Av. da Educação, 321 - Centro',
            latitude: -22.9068,
            longitude: -43.1729,
            userId: 'user_4',
            createdAt: DateTime.now().subtract(const Duration(hours: 1)),
            updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
            fotos: ['foto6.jpg'],
            metadata: {
              'solicitanteNome': 'Ana Oliveira',
              'solicitanteTelefone': '(21) 66666-6666',
              'observacoes': 'Câmeras de segurança podem ter capturado os vândalos',
            },
          ),
        ]);
        _isLoading = false;
      });
    });
  }

  List<Ocorrencia> get _filteredOcorrencias {
    if (_filterStatus == 'Todas') {
      return _ocorrencias;
    }
    return _ocorrencias.where((oc) {
      switch (_filterStatus) {
        case 'Nova':
          return oc.status == OcorrenciaStatus.pendente;
        case 'Pendente':
          return oc.status == OcorrenciaStatus.pendente;
        case 'Em Andamento':
          return oc.status == OcorrenciaStatus.emAndamento;
        case 'Resolvida':
          return oc.status == OcorrenciaStatus.concluida;
        default:
          return true;
      }
    }).toList();
  }

  Color _getStatusColor(OcorrenciaStatus status) {
    switch (status) {
      case OcorrenciaStatus.pendente:
        return Colors.blue;
      case OcorrenciaStatus.pendente:
        return Colors.orange;
      case OcorrenciaStatus.emAndamento:
        return Colors.yellow[700]!;
      case OcorrenciaStatus.concluida:
        return Colors.green;
      case OcorrenciaStatus.cancelada:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(OcorrenciaPrioridade prioridade) {
    switch (prioridade) {
      case OcorrenciaPrioridade.baixa:
        return Colors.green;
      case OcorrenciaPrioridade.media:
        return Colors.orange;
      case OcorrenciaPrioridade.alta:
        return Colors.red;
      case OcorrenciaPrioridade.emergencia:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ocorrências'),
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
                  child: _buildStatCard('Total', _ocorrencias.length.toString(), Icons.list),
                ),
                Expanded(
                  child: _buildStatCard('Pendentes', 
                    _ocorrencias.where((o) => o.status == OcorrenciaStatus.pendente).length.toString(), 
                    Icons.pending),
                ),
                                 Expanded(
                   child: _buildStatCard('Concluídas', 
                     _ocorrencias.where((o) => o.status == OcorrenciaStatus.concluida).length.toString(), 
                     Icons.check_circle),
                 ),
              ],
            ),
          ),

          // Lista de ocorrências
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredOcorrencias.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Nenhuma ocorrência encontrada',
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
                        itemCount: _filteredOcorrencias.length,
                        itemBuilder: (context, index) {
                          final ocorrencia = _filteredOcorrencias[index];
                          return _buildOcorrenciaCard(ocorrencia);
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewOcorrenciaDialog,
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: AppConfig.primaryColor, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOcorrenciaCard(Ocorrencia ocorrencia) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(ocorrencia.status),
          child: Icon(
            _getOcorrenciaIcon(ocorrencia.tipo),
            color: Colors.white,
          ),
        ),
        title: Text(
          ocorrencia.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ocorrencia.descricao),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(ocorrencia.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(ocorrencia.status),
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
                    color: _getPriorityColor(ocorrencia.prioridade),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getPriorityText(ocorrencia.prioridade),
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
              '${DateFormat('dd/MM/yyyy HH:mm').format(ocorrencia.createdAt)} • ${ocorrencia.endereco}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleOcorrenciaAction(value, ocorrencia),
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
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Excluir', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: () => _showOcorrenciaDetails(ocorrencia),
      ),
    );
  }

  IconData _getOcorrenciaIcon(OcorrenciaTipo tipo) {
    switch (tipo) {
      case OcorrenciaTipo.acidente:
        return Icons.car_crash;
      case OcorrenciaTipo.crime:
        return Icons.security;
      case OcorrenciaTipo.incendio:
        return Icons.local_fire_department;
      case OcorrenciaTipo.enchente:
        return Icons.water_drop;
      case OcorrenciaTipo.deslizamento:
        return Icons.terrain;
      case OcorrenciaTipo.transito:
        return Icons.traffic;
      case OcorrenciaTipo.saude:
        return Icons.medical_services;
      case OcorrenciaTipo.outros:
        return Icons.report;
    }
  }

  String _getStatusText(OcorrenciaStatus status) {
    switch (status) {
      case OcorrenciaStatus.pendente:
        return 'PENDENTE';
      case OcorrenciaStatus.emAndamento:
        return 'EM ANDAMENTO';
      case OcorrenciaStatus.concluida:
        return 'CONCLUÍDA';
      case OcorrenciaStatus.cancelada:
        return 'CANCELADA';
    }
  }

  String _getPriorityText(OcorrenciaPrioridade prioridade) {
    switch (prioridade) {
      case OcorrenciaPrioridade.baixa:
        return 'BAIXA';
      case OcorrenciaPrioridade.media:
        return 'MÉDIA';
      case OcorrenciaPrioridade.alta:
        return 'ALTA';
      case OcorrenciaPrioridade.emergencia:
        return 'EMERGÊNCIA';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar Ocorrências'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'Todas',
            'Nova',
            'Pendente',
            'Em Andamento',
            'Resolvida',
          ].map((status) => RadioListTile<String>(
            title: Text(status),
            value: status,
            groupValue: _filterStatus,
            onChanged: (value) {
              setState(() {
                _filterStatus = value!;
              });
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showOcorrenciaDetails(Ocorrencia ocorrencia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ocorrencia.titulo),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('**Descrição:** ${ocorrencia.descricao}'),
              const SizedBox(height: 8),
              Text('**Endereço:** ${ocorrencia.endereco}'),
              const SizedBox(height: 8),
              Text('**Status:** ${_getStatusText(ocorrencia.status)}'),
              const SizedBox(height: 8),
              Text('**Prioridade:** ${_getPriorityText(ocorrencia.prioridade)}'),
              const SizedBox(height: 8),
                             Text('**Solicitante:** ${ocorrencia.metadata?['solicitanteNome'] ?? 'N/A'}'),
               const SizedBox(height: 8),
               Text('**Telefone:** ${ocorrencia.metadata?['solicitanteTelefone'] ?? 'N/A'}'),
               const SizedBox(height: 8),
               Text('**Data:** ${DateFormat('dd/MM/yyyy HH:mm').format(ocorrencia.createdAt)}'),
               if (ocorrencia.metadata?['observacoes'] != null) ...[
                 const SizedBox(height: 8),
                 Text('**Observações:** ${ocorrencia.metadata!['observacoes']}'),
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

  void _showNewOcorrenciaDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Ocorrência'),
        content: const Text('Funcionalidade de criação de ocorrências será implementada em breve.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleOcorrenciaAction(String action, Ocorrencia ocorrencia) {
    switch (action) {
      case 'view':
        _showOcorrenciaDetails(ocorrencia);
        break;
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Funcionalidade de edição será implementada')),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(ocorrencia);
        break;
    }
  }

  void _showDeleteConfirmation(Ocorrencia ocorrencia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem certeza que deseja excluir a ocorrência "${ocorrencia.titulo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _ocorrencias.remove(ocorrencia);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ocorrência excluída com sucesso')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
