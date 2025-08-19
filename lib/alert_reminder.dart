import 'dart:async';
import 'package:flutter/material.dart';

class AlertReminder {
  static Timer? _timer;

  static void startHourlyAlert(BuildContext context) {
    // Cancela qualquer timer anterior
    _timer?.cancel();

    // Inicia um novo timer que dispara a cada hora
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Hora de beber água!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  static void stopHourlyAlert() {
    _timer?.cancel();
  }
}