enum UserRole { patient, family, doctor }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<EmergencyContact>? emergencyContacts;
  final AlertPreferences? alertPreferences;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.emergencyContacts,
    this.alertPreferences,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      emergencyContacts: json['emergency_contacts'] != null
          ? (json['emergency_contacts'] as List)
              .map((e) => EmergencyContact.fromJson(e))
              .toList()
          : null,
      alertPreferences: json['alert_preferences'] != null
          ? AlertPreferences.fromJson(json['alert_preferences'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.toString().split('.').last,
      'emergency_contacts': emergencyContacts?.map((e) => e.toJson()).toList(),
      'alert_preferences': alertPreferences?.toJson(),
    };
  }
}

class EmergencyContact {
  final String id;
  final String name;
  final String phone;
  final String relationship;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.relationship,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      relationship: json['relationship'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'relationship': relationship,
    };
  }
}

class AlertPreferences {
  final bool whatsapp;
  final bool sms;
  final bool call;

  AlertPreferences({
    required this.whatsapp,
    required this.sms,
    required this.call,
  });

  factory AlertPreferences.fromJson(Map<String, dynamic> json) {
    return AlertPreferences(
      whatsapp: json['whatsapp'] ?? true,
      sms: json['sms'] ?? true,
      call: json['call'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'whatsapp': whatsapp,
      'sms': sms,
      'call': call,
    };
  }
}
