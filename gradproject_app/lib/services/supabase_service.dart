import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  final SupabaseClient client = Supabase.instance.client;

  /// تسجيل مستخدم جديد
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String role,
    required String name,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {
        'role': role,
        'name': name,
      },
    );
    return response;
  }

  /// تسجيل الدخول
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// استرجاع بيانات المستخدم من جدول users
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final response =
        await client.from('users').select().eq('id', userId).single();
    return response;
  }
}
