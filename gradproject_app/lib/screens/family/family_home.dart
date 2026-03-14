import 'package:flutter/material.dart';

class FamilyHomeScreen extends StatelessWidget {
  const FamilyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('متابعة المريض')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('اسم المريض'),
                subtitle: const Text('آخر تحديث: منذ 10 دقائق'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.red.shade50,
              child: ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: const Text('حالة اليوم'),
                subtitle: const Text('يوجد توتر مرتفع'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
