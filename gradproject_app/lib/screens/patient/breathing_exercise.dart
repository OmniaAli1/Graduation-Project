import 'dart:async';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  
  BreathingPhase _phase = BreathingPhase.inhale;
  int _count = 4;
  int _cycleCount = 0;
  bool _isActive = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _startExercise() {
    setState(() {
      _isActive = true;
      _cycleCount = 0;
    });
    _runPhase();
  }

  void _stopExercise() {
    setState(() => _isActive = false);
    _timer?.cancel();
    _controller.stop();
    _controller.reset();
  }

  void _runPhase() {
    if (!_isActive) return;

    switch (_phase) {
      case BreathingPhase.inhale:
        _controller.duration = const Duration(seconds: 4);
        _controller.forward(from: 0);
        _count = 4;
        break;
      case BreathingPhase.hold:
        _controller.duration = const Duration(seconds: 7);
        _count = 7;
        break;
      case BreathingPhase.exhale:
        _controller.duration = const Duration(seconds: 8);
        _controller.reverse(from: 1);
        _count = 8;
        break;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isActive) {
        timer.cancel();
        return;
      }

      setState(() {
        _count--;
        if (_count <= 0) {
          timer.cancel();
          _nextPhase();
        }
      });
    });
  }

  void _nextPhase() {
    setState(() {
      switch (_phase) {
        case BreathingPhase.inhale:
          _phase = BreathingPhase.hold;
          break;
        case BreathingPhase.hold:
          _phase = BreathingPhase.exhale;
          break;
        case BreathingPhase.exhale:
          _phase = BreathingPhase.inhale;
          _cycleCount++;
          break;
      }
    });
    _runPhase();
  }

  Color _getPhaseColor() {
    switch (_phase) {
      case BreathingPhase.inhale:
        return const Color(0xFF3B82F6); // Blue
      case BreathingPhase.hold:
        return const Color(0xFF8B5CF6); // Purple
      case BreathingPhase.exhale:
        return const Color(0xFF10B981); // Green
    }
  }

  String _getPhaseText() {
    switch (_phase) {
      case BreathingPhase.inhale:
        return 'Breathe in slowly through your nose...';
      case BreathingPhase.hold:
        return 'Hold your breath gently...';
      case BreathingPhase.exhale:
        return 'Breathe out slowly through your mouth...';
    }
  }

  String _getPhaseName() {
    switch (_phase) {
      case BreathingPhase.inhale:
        return 'INHALE';
      case BreathingPhase.hold:
        return 'HOLD';
      case BreathingPhase.exhale:
        return 'EXHALE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[900]!,
              Colors.purple[900]!,
              Colors.pink[900]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Close Button
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                ),
              ),
              
              // Main Content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const Icon(
                        Icons.air,
                        color: Colors.white,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '4-7-8 Breathing Exercise',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Follow the circle and breathe',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 48),
                      
                      // Cycle Counter
                      if (_isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Cycle: $_cycleCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      
                      // Animated Circle
                      AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    _getPhaseColor(),
                                    _getPhaseColor().withOpacity(0.6),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _getPhaseColor().withOpacity(0.6),
                                    blurRadius: 50,
                                    spreadRadius: 20,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _isActive ? '$_count' : '●',
                                      style: const TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (_isActive)
                                      Text(
                                        _getPhaseName(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 2,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 64),
                      
                      // Instructions Card
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _isActive ? _getPhaseText() : 'Press "Start" to begin',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Control Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isActive ? _stopExercise : _startExercise,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isActive
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.white,
                                  foregroundColor:
                                      _isActive ? Colors.white : Colors.blue[900],
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: _isActive ? 0 : 8,
                                ),
                                child: Text(
                                  _isActive ? 'Pause' : 'Start Exercise',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Tip
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.lightbulb_outline, color: Colors.amber, size: 24),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Repeat for 4-5 cycles for best results',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

enum BreathingPhase { inhale, hold, exhale }