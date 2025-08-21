import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/config/app_config.dart';
import '../../data/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMockUser();
  }

  void _loadMockUser() {
    _user = User(
      id: 'user_123',
      name: 'João Silva Santos',
      email: 'joao.silva@email.com',
      phone: '(21) 99999-9999',
      type: UserType.citizen,
      status: UserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
    );

    _nameController.text = _user.name;
    _phoneController.text = _user.phone ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : _startEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto do perfil
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppConfig.primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppConfig.primaryColor,
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppConfig.primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: _changeProfilePhoto,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Informações do usuário
            if (_isEditing) _buildEditForm() else _buildProfileInfo(),

            const SizedBox(height: 24),

            // Estatísticas
            _buildStatistics(),

            const SizedBox(height: 24),

            // Configurações
            _buildSettings(),

            const SizedBox(height: 24),

            // Ações
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome Completo',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Telefone',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu telefone';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: _user.email,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Email (não pode ser alterado)',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Nome', _user.name, Icons.person),
        const SizedBox(height: 16),
        _buildInfoRow('Email', _user.email, Icons.email),
        const SizedBox(height: 16),
        _buildInfoRow('Telefone', _user.phone ?? 'Não informado', Icons.phone),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Tipo de Usuário',
          _getUserTypeText(_user.type),
          Icons.badge,
        ),
        const SizedBox(height: 16),
        _buildInfoRow('Status', _getUserStatusText(_user.status), Icons.circle),
        const SizedBox(height: 16),
        _buildInfoRow(
          'Membro desde',
          DateFormat('dd/MM/yyyy').format(_user.createdAt),
          Icons.calendar_today,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppConfig.primaryColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estatísticas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Ocorrências Reportadas',
                    '12',
                    Icons.report,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Dias Ativo',
                    '365',
                    Icons.calendar_today,
                  ),
                ),
                Expanded(
                  child: _buildStatItem('Avaliações', '4.8', Icons.star),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppConfig.primaryColor, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSettings() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notificações'),
            subtitle: const Text('Configurar alertas e notificações'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openNotificationsSettings,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacidade'),
            subtitle: const Text('Configurações de privacidade'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openPrivacySettings,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Idioma'),
            subtitle: const Text('Português (Brasil)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openLanguageSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text('Ajuda e Suporte'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openHelp,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.green),
            title: const Text('Sobre o App'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _openAbout,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair da Conta'),
            onTap: _logout,
          ),
        ],
      ),
    );
  }

  String _getUserTypeText(UserType type) {
    switch (type) {
      case UserType.citizen:
        return 'Cidadão';
      case UserType.agent:
        return 'Agente Público';
      case UserType.admin:
        return 'Administrador';
    }
  }

  String _getUserStatusText(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return 'Ativo';
      case UserStatus.inactive:
        return 'Inativo';
      case UserStatus.suspended:
        return 'Suspenso';
    }
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _user = _user.copyWith(
          name: _nameController.text,
          phone: _phoneController.text,
        );
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _changeProfilePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de alteração de foto será implementada'),
      ),
    );
  }

  void _openNotificationsSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configurações de Notificações'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Notificações Push'),
              subtitle: Text('Receber alertas em tempo real'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Notificações de Ocorrências'),
              subtitle: Text('Atualizações sobre suas ocorrências'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Notificações de Trânsito'),
              subtitle: Text('Alertas de trânsito na sua região'),
              value: false,
              onChanged: null,
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

  void _openPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configurações de privacidade serão implementadas'),
      ),
    );
  }

  void _openLanguageSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configurações de idioma serão implementadas'),
      ),
    );
  }

  void _openHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajuda e Suporte'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('**Como usar o app:**'),
            SizedBox(height: 8),
            Text('• Use o botão de pânico em emergências'),
            Text('• Registre ocorrências através do menu'),
            Text('• Acompanhe o trânsito em tempo real'),
            Text('• Entre em contato pelo chat interno'),
            SizedBox(height: 16),
            Text('**Contato:**'),
            Text('Email: suporte@app.gov.br'),
            Text('Telefone: (21) 3000-0000'),
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

  void _openAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre o App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('**App Institucional v1.0.0**'),
            SizedBox(height: 8),
            Text(
              'Aplicativo multiplataforma para órgãos públicos e forças de segurança.',
            ),
            SizedBox(height: 16),
            Text('**Desenvolvido por:**'),
            Text('Equipe de TI da Prefeitura'),
            SizedBox(height: 8),
            Text('**© 2024 - Todos os direitos reservados**'),
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

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Saída'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Aqui você pode adicionar a lógica de logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout realizado com sucesso')),
              );
            },
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
