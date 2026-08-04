import 'package:flutter/material.dart';
import '../widgets/emergency_contacts_row.dart';

class SosHomeTab extends StatefulWidget {
  const SosHomeTab({super.key});

  @override
  State<SosHomeTab> createState() => _SosHomeTabState();
}

class _SosHomeTabState extends State<SosHomeTab>
    with SingleTickerProviderStateMixin {
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);
  static const Duration _holdDuration = Duration(seconds: 2);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _holdDuration,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sendAlert();
      }
    });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startHold() => _controller.forward(from: _controller.value);

  void _cancelHold() {
    if (_controller.isAnimating) {
      _controller.reverse();
    }
  }

  void _sendAlert() {
    _controller.stop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🚨 SOS alert sent to your emergency contacts'),
        backgroundColor: kPrimary,
      ),
    );
    _controller.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'EMERGENCY',
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              'SOS',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Press and hold to\nsend alert',
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextDark.withValues(alpha: 0.7)),
            ),
            const Spacer(),
            GestureDetector(
              onLongPressStart: (_) => _startHold(),
              onLongPressEnd: (_) => _cancelHold(),
              onLongPressCancel: _cancelHold,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final scale = 1.0 + (_controller.value * 0.15);
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: CircularProgressIndicator(
                          value: _controller.value,
                          strokeWidth: 6,
                          backgroundColor: Colors.red.withValues(alpha: 0.15),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                      Transform.scale(scale: scale, child: child),
                    ],
                  );
                },
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33FF0000),
                        blurRadius: 30,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'press & hold',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final holding = _controller.value > 0;
                return Opacity(
                  opacity: holding ? 1 : 0.55,
                  child: GestureDetector(
                    onTap: holding ? _cancelHold : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: kPrimary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.close, size: 16, color: kPrimary),
                          const SizedBox(width: 6),
                          Text(
                            holding ? 'Release to cancel' : 'Slide to cancel',
                            style: const TextStyle(
                              color: kPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Location will be shared with',
                    style: TextStyle(
                      fontSize: 13,
                      color: kTextDark.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const EmergencyContactsRow(),
                  const SizedBox(height: 10),
                  Text(
                    'And nearest Authorities.',
                    style: TextStyle(
                      fontSize: 12,
                      color: kTextDark.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}