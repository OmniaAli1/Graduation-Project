import 'package:flutter/material.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final relationController = TextEditingController();

  void saveContact() {

    String name = nameController.text;
    String phone = phoneController.text;
    String relation = relationController.text;

    // هنا هنبعت البيانات للداتابيز أو API
    print(name);
    print(phone);
    print(relation);

    // بعد الحفظ يفتح الداشبورد
    Navigator.pushReplacementNamed(context, "/patientDashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Contact Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
              ),
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 15),

            TextField(
              controller: relationController,
              decoration: const InputDecoration(
                labelText: "Relationship",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: saveContact,
              child: const Text("Save Contact"),
            )

          ],
        ),
      ),
    );
  }
}