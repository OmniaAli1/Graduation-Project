import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  // Medical History Answers
  Map<String, dynamic> medicalHistory = {
    'hasHeartDisease': false,
    'hasHighBloodPressure': false,
    'hasDiabetes': false,
    'hasAsthma': false,
    'hasArthritis': false,
    'isPregnant': false,
    'hasSurgery': false,
    'takingMedications': false,
    'medicationsList': '',
    'allergies': '',
    'panicFrequency': 'occasional', // occasional, frequent, daily
    'panicTriggers': <String>[],
    'physicalLimitations': '',
    'exerciseLevel': 'beginner', // beginner, intermediate, advanced
  };

  bool isHistoryComplete = false;

  final List<String> commonTriggers = [
    'Crowded places',
    'Public transport',
    'Heights',
    'Social situations',
    'Health concerns',
    'Work stress',
    'Financial worries',
    'Relationships',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History & Exercises'),
        backgroundColor: AppColors.patientPrimary,
        foregroundColor: Colors.white,
      ),
      body: isHistoryComplete
          ? _buildExerciseRecommendations()
          : _buildMedicalHistoryForm(),
    );
  }

  Widget _buildMedicalHistoryForm() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header Card
        Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.medical_information, 
                  size: 48, 
                  color: AppColors.patientPrimary,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Complete Your Medical History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This helps us recommend safe exercises tailored to your condition',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Medical Conditions Section
        const Text(
          'Medical Conditions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildCheckboxTile(
          'Heart Disease or Heart Problems',
          'hasHeartDisease',
          Icons.favorite,
        ),
        _buildCheckboxTile(
          'High Blood Pressure',
          'hasHighBloodPressure',
          Icons.trending_up,
        ),
        _buildCheckboxTile(
          'Diabetes',
          'hasDiabetes',
          Icons.bloodtype,
        ),
        _buildCheckboxTile(
          'Asthma or Breathing Problems',
          'hasAsthma',
          Icons.air,
        ),
        _buildCheckboxTile(
          'Arthritis or Joint Problems',
          'hasArthritis',
          Icons.accessibility_new,
        ),
        _buildCheckboxTile(
          'Pregnant',
          'isPregnant',
          Icons.pregnant_woman,
        ),
        _buildCheckboxTile(
          'Recent Surgery (last 6 months)',
          'hasSurgery',
          Icons.healing,
        ),
        const SizedBox(height: 24),

        // Medications Section
        const Text(
          'Current Medications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildCheckboxTile(
          'Currently Taking Medications',
          'takingMedications',
          Icons.medication,
        ),

        if (medicalHistory['takingMedications'])
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'List your medications',
                  hintText: 'e.g., Sertraline 50mg, Propranolol 10mg',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    medicalHistory['medicationsList'] = value;
                  });
                },
              ),
            ),
          ),
        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Allergies (if any)',
                hintText: 'e.g., Peanuts, Penicillin',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  medicalHistory['allergies'] = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Panic Attack Information
        const Text(
          'Panic Attack History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How often do you experience panic attacks?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                
                _buildFrequencyOption('Occasionally (few times a month)', 'occasional'),
                _buildFrequencyOption('Frequently (several times a week)', 'frequent'),
                _buildFrequencyOption('Daily or multiple times daily', 'daily'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What triggers your panic attacks?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Text(
                  'Select all that apply',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: commonTriggers.map((trigger) {
                    final isSelected = medicalHistory['panicTriggers'].contains(trigger);
                    return FilterChip(
                      label: Text(trigger),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            medicalHistory['panicTriggers'].add(trigger);
                          } else {
                            medicalHistory['panicTriggers'].remove(trigger);
                          }
                        });
                      },
                      backgroundColor: Colors.grey[100],
                      selectedColor: AppColors.patientPrimary.withOpacity(0.2),
                      checkmarkColor: AppColors.patientPrimary,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Physical Activity Level
        const Text(
          'Physical Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current exercise level',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                
                _buildExerciseLevelOption(
                  'Beginner',
                  'Little to no regular exercise',
                  'beginner',
                ),
                _buildExerciseLevelOption(
                  'Intermediate',
                  'Exercise 2-3 times per week',
                  'intermediate',
                ),
                _buildExerciseLevelOption(
                  'Advanced',
                  'Regular exercise 4+ times per week',
                  'advanced',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Any physical limitations?',
                hintText: 'e.g., knee pain, back problems, limited mobility',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  medicalHistory['physicalLimitations'] = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitMedicalHistory,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.patientPrimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Get Exercise Recommendations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCheckboxTile(String title, String key, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        value: medicalHistory[key],
        onChanged: (value) {
          setState(() {
            medicalHistory[key] = value ?? false;
          });
        },
        title: Text(title),
        secondary: Icon(icon, color: AppColors.patientPrimary),
        activeColor: AppColors.patientPrimary,
      ),
    );
  }

  Widget _buildFrequencyOption(String label, String value) {
    return RadioListTile<String>(
      value: value,
      groupValue: medicalHistory['panicFrequency'],
      onChanged: (newValue) {
        setState(() {
          medicalHistory['panicFrequency'] = newValue;
        });
      },
      title: Text(label),
      activeColor: AppColors.patientPrimary,
    );
  }

  Widget _buildExerciseLevelOption(String title, String subtitle, String value) {
    return RadioListTile<String>(
      value: value,
      groupValue: medicalHistory['exerciseLevel'],
      onChanged: (newValue) {
        setState(() {
          medicalHistory['exerciseLevel'] = newValue;
        });
      },
      title: Text(title),
      subtitle: Text(subtitle),
      activeColor: AppColors.patientPrimary,
    );
  }

  void _submitMedicalHistory() {
    setState(() {
      isHistoryComplete = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medical history saved! Generating recommendations...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildExerciseRecommendations() {
    final recommendations = _generateRecommendations();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Success Card
        Card(
          color: Colors.green[50],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 64,
                  color: Colors.green[700],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Personalized Plan Ready!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Based on your medical history, we\'ve created a safe exercise plan',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Recommendations
        const Text(
          'Recommended Exercises',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        ...recommendations.map((exercise) => _buildExerciseCard(exercise)),

        const SizedBox(height: 24),

        // Edit History Button
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              isHistoryComplete = false;
            });
          },
          icon: const Icon(Icons.edit),
          label: const Text('Update Medical History'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  List<Exercise> _generateRecommendations() {
    List<Exercise> exercises = [];

    // Always include breathing (safe for everyone)
    exercises.add(Exercise(
      name: '4-7-8 Breathing Technique',
      duration: '5-10 minutes',
      frequency: 'Daily, especially before sleep',
      benefits: 'Reduces anxiety, promotes calmness',
      precautions: 'None - Safe for everyone',
      time: 'Morning & Evening',
      difficulty: 'Beginner',
    ));

    // Progressive Muscle Relaxation (safe for most)
    if (!medicalHistory['hasArthritis']) {
      exercises.add(Exercise(
        name: 'Progressive Muscle Relaxation',
        duration: '10-15 minutes',
        frequency: 'Daily',
        benefits: 'Reduces muscle tension and stress',
        precautions: medicalHistory['hasArthritis'] 
            ? 'Avoid if joints are inflamed' 
            : 'None',
        time: 'Evening',
        difficulty: 'Beginner',
      ));
    }

    // Walking (adjust based on conditions)
    if (!medicalHistory['hasHeartDisease'] && !medicalHistory['hasSurgery']) {
      exercises.add(Exercise(
        name: 'Gentle Walking',
        duration: medicalHistory['exerciseLevel'] == 'beginner' 
            ? '15-20 minutes' 
            : '30-45 minutes',
        frequency: '3-5 times per week',
        benefits: 'Improves cardiovascular health, reduces anxiety',
        precautions: medicalHistory['hasHighBloodPressure']
            ? 'Monitor heart rate, start slowly'
            : 'Stay hydrated',
        time: 'Morning or Afternoon',
        difficulty: medicalHistory['exerciseLevel'] == 'beginner' 
            ? 'Beginner' 
            : 'Intermediate',
      ));
    }

    // Yoga (modified for conditions)
    if (!medicalHistory['isPregnant'] && !medicalHistory['hasSurgery']) {
      exercises.add(Exercise(
        name: 'Gentle Yoga',
        duration: '20-30 minutes',
        frequency: '2-3 times per week',
        benefits: 'Improves flexibility, reduces stress',
        precautions: medicalHistory['hasArthritis']
            ? 'Avoid deep bends, use modifications'
            : medicalHistory['hasHighBloodPressure']
                ? 'Avoid inversions'
                : 'Listen to your body',
        time: 'Morning',
        difficulty: 'Beginner',
      ));
    }

    // Swimming (good for heart, low impact)
    if (!medicalHistory['hasAsthma'] && 
        !medicalHistory['hasSurgery'] &&
        medicalHistory['exerciseLevel'] != 'beginner') {
      exercises.add(Exercise(
        name: 'Swimming or Water Aerobics',
        duration: '20-30 minutes',
        frequency: '2 times per week',
        benefits: 'Low-impact cardio, strengthens muscles',
        precautions: medicalHistory['hasAsthma']
            ? 'Warm up properly, have inhaler nearby'
            : 'Start slowly',
        time: 'Afternoon',
        difficulty: 'Intermediate',
      ));
    }

    // Tai Chi (great for anxiety, gentle)
    exercises.add(Exercise(
      name: 'Tai Chi',
      duration: '15-20 minutes',
      frequency: '3 times per week',
      benefits: 'Improves balance, reduces anxiety',
      precautions: medicalHistory['hasArthritis']
          ? 'Use gentle movements'
          : 'None',
      time: 'Morning',
      difficulty: 'Beginner',
    ));

    // Stretching (always safe)
    exercises.add(Exercise(
      name: 'Gentle Stretching',
      duration: '10 minutes',
      frequency: 'Daily',
      benefits: 'Increases flexibility, reduces tension',
      precautions: 'Don\'t force stretches',
      time: 'Morning & Evening',
      difficulty: 'Beginner',
    ));

    return exercises;
  }

  Widget _buildExerciseCard(Exercise exercise) {
    Color difficultyColor;
    switch (exercise.difficulty.toLowerCase()) {
      case 'beginner':
        difficultyColor = Colors.green;
        break;
      case 'intermediate':
        difficultyColor = Colors.orange;
        break;
      default:
        difficultyColor = Colors.red;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.patientPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.fitness_center,
            color: AppColors.patientPrimary,
          ),
        ),
        title: Text(
          exercise.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text('${exercise.frequency} • ${exercise.time}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exercise.difficulty,
                        style: TextStyle(
                          color: difficultyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(exercise.duration),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                
                _buildInfoRow(Icons.check_circle, 'Benefits', exercise.benefits, Colors.green),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.warning_amber, 'Precautions', exercise.precautions, Colors.orange),
                const SizedBox(height: 16),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Starting ${exercise.name}...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.patientPrimary,
                    ),
                    child: const Text('Start Exercise'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Exercise {
  final String name;
  final String duration;
  final String frequency;
  final String benefits;
  final String precautions;
  final String time;
  final String difficulty;

  Exercise({
    required this.name,
    required this.duration,
    required this.frequency,
    required this.benefits,
    required this.precautions,
    required this.time,
    required this.difficulty,
  });
}