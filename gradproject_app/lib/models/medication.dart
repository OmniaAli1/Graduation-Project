class Medication {
  final String id;
  final String name;
  final String dosage;
  final String time;
  final String frequency;
  final bool taken;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.frequency,
    this.taken = false,
  });

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    String? time,
    String? frequency,
    bool? taken,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      frequency: frequency ?? this.frequency,
      taken: taken ?? this.taken,
    );
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      time: json['time'],
      frequency: json['frequency'],
      taken: json['taken'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'time': time,
      'frequency': frequency,
      'taken': taken,
    };
  }
}
