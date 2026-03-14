import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/auth_screen.dart';
// import 'screens/patient/emergency_contact_screen.dart';
import 'screens/patient/patient_dashboard.dart';
import 'screens/family/family_dashboard.dart';
import 'screens/doctor/doctor_dashboard.dart';
import 'models/user.dart';
import 'constants/colors.dart';

void main() {
  runApp(const CalmLinkApp());
}

class CalmLinkApp extends StatelessWidget {
  const CalmLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'CalmLink',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.patientPrimary,
          ),
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.currentUser == null) {
          return const AuthScreen();
        }

        // اختيار الشاشة حسب الدور
        switch (appState.currentUser!.role) {
          case UserRole.patient:
            return const PatientDashboard();
          case UserRole.family:
            return const FamilyDashboard();
          case UserRole.doctor:
            return const DoctorDashboard();
        }
      },
    );
  }
}

// ---------------- AppState ----------------

class AppState extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // تسجيل دخول
  void login(User user) {
    _currentUser = user;
    notifyListeners();
  }

  // تسجيل خروج
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
