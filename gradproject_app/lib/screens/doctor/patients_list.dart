import 'package:flutter/material.dart';

class PatientsListScreen extends StatelessWidget {
  const PatientsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      {'name': 'أحمد محمد', 'status': 'مستقر'},
      {'name': 'سارة علي', 'status': 'يحتاج متابعة'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('المرضى')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(patient['name']!),
              trailing: Text(
                patient['status']!,
                style: TextStyle(
                  color: patient['status'] == 'مستقر'
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
