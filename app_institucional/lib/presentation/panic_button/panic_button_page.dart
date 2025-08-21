import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/app_config.dart';

class PanicButtonPage extends StatefulWidget {
  const PanicButtonPage({super.key});

  @override
  State<PanicButtonPage> createState() => _PanicButtonPageState();
}

class _PanicButtonPageState extends State<PanicButtonPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;
  bool _isPressed = false;
  String _location = 'Obtendo localização...';

  @override
  void initState() {
    super.initState();
    
    // Animação de pulso
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Animação de tremor
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    // Iniciar animação de pulso
    _pulseController.repeat(reverse: true);
    
    // Simular obtenção de localização
    _getLocation();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    // Simular delay de obtenção de localização
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _location = 'Localização obtida com sucesso';
    });
  }

  Future<void> _showEmergencyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[50],
          title: Row(
            children: [
              Icon(Icons.emergency, color: Colors.red, size: 32),
              const SizedBox(width: 8),
              const Text(
                'EMERGÊNCIA!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Você está prestes a acionar o botão de pânico.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                'Isso irá:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Enviar alerta para as autoridades'),
              Text('• Fazer uma ligação para 190'),
              Text('• Compartilhar sua localização'),
              SizedBox(height: 12),
              Text(
                'Tem certeza que deseja continuar?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _triggerEmergency();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('CONFIRMAR'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _triggerEmergency() async {
    setState(() {
      _isPressed = true;
    });

    // Iniciar animação de tremor
    _shakeController.forward();

    // Simular envio de alerta
    await Future.delayed(const Duration(seconds: 1));
    
    // Mostrar feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alerta enviado! Ligando para 190...'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    // Fazer ligação para 190
    await _makeEmergencyCall();

    // Resetar estado
    if (mounted) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  Future<void> _makeEmergencyCall() async {
    const phoneNumber = 'tel:190';
    final Uri uri = Uri.parse(phoneNumber);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Não foi possível fazer a ligação'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao fazer ligação: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botão de Pânico'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red[50]!,
              Colors.red[100]!,
              Colors.red[200]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Status da localização
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: _location.contains('sucesso') 
                              ? Colors.green 
                              : Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Localização',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(_location),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Instruções
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 32,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Use este botão apenas em caso de emergência real',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'O sistema irá enviar sua localização e fazer uma ligação para 190 automaticamente',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),

                // Botão de Pânico
                AnimatedBuilder(
                  animation: _isPressed ? _shakeAnimation : _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _isPressed ? 1.0 : _pulseAnimation.value,
                      child: Transform.translate(
                        offset: _isPressed 
                            ? Offset(_shakeAnimation.value, 0)
                            : Offset.zero,
                        child: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _isPressed = true;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _isPressed = false;
                            });
                            _showEmergencyDialog();
                          },
                          onTapCancel: () {
                            setState(() {
                              _isPressed = false;
                            });
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isPressed ? Colors.red[700] : Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: _isPressed ? 20 : 30,
                                  spreadRadius: _isPressed ? 5 : 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.emergency,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'PÂNICO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),

                // Aviso legal
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.orange,
                        size: 24,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Uso indevido pode resultar em penalidades',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
