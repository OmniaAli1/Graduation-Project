import 'package:flutter/material.dart';

class AlertsHistoryScreen extends StatelessWidget {
  const AlertsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      {
        'date': '27 أكتوبر',
        'type': 'نوبة هلع',
        'status': 'تم التواصل'
      },
      {
        'date': '25 أكتوبر',
        'type': 'ضغط مرتفع',
        'status': 'لم يتم الرد'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('سجل التنبيهات')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_active),
              title: Text(alert['type']!),
              subtitle: Text(alert['date']!),
              trailing: Text(
                alert['status']!,
                style: TextStyle(
                  color: alert['status'] == 'تم التواصل'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
