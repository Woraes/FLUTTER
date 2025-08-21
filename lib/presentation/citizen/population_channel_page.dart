import 'package:flutter/material.dart';
import '../../core/config/app_config.dart';
import '../../data/models/citizen_features.dart';

class PopulationChannelPage extends StatefulWidget {
  const PopulationChannelPage({super.key});

  @override
  State<PopulationChannelPage> createState() => _PopulationChannelPageState();
}

class _PopulationChannelPageState extends State<PopulationChannelPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: AppConfig.secondaryColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Canal da População',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Canal direto de comunicação com a população',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Tabs
          Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: _buildTab(0, 'Denúncias', Icons.report),
                ),
                Expanded(
                  child: _buildTab(1, 'Sugestões', Icons.lightbulb),
                ),
                Expanded(
                  child: _buildTab(2, 'Reclamações', Icons.feedback),
                ),
                Expanded(
                  child: _buildTab(3, 'Pesquisas', Icons.poll),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildAnonymousReportsTab(),
                _buildSuggestionsTab(),
                _buildComplaintsTab(),
                _buildSurveysTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppConfig.secondaryColor : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppConfig.secondaryColor : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppConfig.secondaryColor : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnonymousReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.red[700],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Denúncias Anônimas',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Reporte situações que precisam de atenção das autoridades de forma anônima e segura.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showAnonymousReportDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Fazer Denúncia Anônima'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Minhas Denúncias',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildAnonymousReportCard(
            'Denúncia de Tráfico',
            'Atividade suspeita em uma residência',
            'Segurança',
            DateTime.now().subtract(const Duration(days: 1)),
          ),
          _buildAnonymousReportCard(
            'Denúncia de Violência',
            'Agitação e gritos vindos de uma casa',
            'Segurança',
            DateTime.now().subtract(const Duration(days: 3)),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.orange[700],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sugestões',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Compartilhe suas ideias para melhorar a cidade e os serviços públicos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showSuggestionDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Enviar Sugestão'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Minhas Sugestões',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildFeedbackCard(
            'Iluminação Pública',
            'Sugestão para instalar mais postes de luz na Rua das Flores',
            'Em análise',
            Colors.blue,
            DateTime.now().subtract(const Duration(days: 2)),
          ),
        ],
      ),
    );
  }

  Widget _buildComplaintsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.feedback,
                        color: Colors.purple[700],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Reclamações',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Reporte problemas e irregularidades que precisam ser corrigidos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showComplaintDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Fazer Reclamação'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Minhas Reclamações',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildFeedbackCard(
            'Buraco na Rua',
            'Buraco grande na Rua da Paz que pode causar acidentes',
            'Em análise',
            Colors.blue,
            DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveysTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.poll,
                        color: Colors.green[700],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Pesquisas Públicas',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Participe de pesquisas e enquetes para ajudar a melhorar os serviços públicos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Pesquisas Disponíveis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSurveyCard(
            'Satisfação com Segurança Pública',
            'Avalie os serviços de segurança em Itaguaí',
            'Ativa',
            Colors.green,
            DateTime.now().subtract(const Duration(days: 5)),
          ),
          
          _buildSurveyCard(
            'Melhorias no Trânsito',
            'Sugestões para melhorar o trânsito da cidade',
            'Ativa',
            Colors.green,
            DateTime.now().subtract(const Duration(days: 3)),
          ),
        ],
      ),
    );
  }

  Widget _buildAnonymousReportCard(String title, String description, String category, DateTime date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red[100],
          child: Icon(Icons.security, color: Colors.red[700]),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showAnonymousReportDetails(title, description, category, date),
      ),
    );
  }

  Widget _buildFeedbackCard(String title, String description, String status, Color statusColor, DateTime date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(Icons.feedback, color: statusColor),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showFeedbackDetails(title, description, status, date),
      ),
    );
  }

  Widget _buildSurveyCard(String title, String description, String status, Color statusColor, DateTime date) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.1),
          child: Icon(Icons.poll, color: statusColor),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(date),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _showSurveyDialog(title),
          child: const Text('Participar'),
        ),
        onTap: () => _showSurveyDetails(title, description, status, date),
      ),
    );
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

  void _showAnonymousReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Denúncia Anônima'),
        content: const Text('Funcionalidade em desenvolvimento. Em breve você poderá fazer denúncias anônimas diretamente pelo app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuggestionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar Sugestão'),
        content: const Text('Funcionalidade em desenvolvimento. Em breve você poderá enviar sugestões diretamente pelo app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showComplaintDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fazer Reclamação'),
        content: const Text('Funcionalidade em desenvolvimento. Em breve você poderá fazer reclamações diretamente pelo app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSurveyDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Participar: $title'),
        content: const Text('Funcionalidade em desenvolvimento. Em breve você poderá participar de pesquisas diretamente pelo app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAnonymousReportDetails(String title, String description, String category, DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Descrição: $description'),
            const SizedBox(height: 8),
            Text('Categoria: $category'),
            const SizedBox(height: 8),
            Text('Data: ${_formatDate(date)}'),
            const SizedBox(height: 8),
            Text('Status: Em análise'),
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

  void _showFeedbackDetails(String title, String description, String status, DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Descrição: $description'),
            const SizedBox(height: 8),
            Text('Status: $status'),
            const SizedBox(height: 8),
            Text('Data: ${_formatDate(date)}'),
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

  void _showSurveyDetails(String title, String description, String status, DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Descrição: $description'),
            const SizedBox(height: 8),
            Text('Status: $status'),
            const SizedBox(height: 8),
            Text('Data: ${_formatDate(date)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSurveyDialog(title);
            },
            child: const Text('Participar'),
          ),
        ],
      ),
    );
  }
}
