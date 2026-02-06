import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'map_screen.dart';
import 'weather_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text('BlueGuide', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF020617)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// WEATHER BADGE
            const _WeatherBadge(),

            const Spacer(),

            /// CENTER CONTENT
            Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.cyanAccent.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
                const SizedBox(height: 6),
                const Text(
                  'BlueGuide',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                _QuickActions(
                  onMapTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MapScreen()),
                    );
                  },
                  onWeatherTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WeatherScreen()),
                    );
                  },
                ),
              ],
            ),

            const Spacer(),

            /// CHAT INPUT BAR
            _ChatInputBar(
              onSend: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- WEATHER BADGE ----------------
class _WeatherBadge extends StatelessWidget {
  const _WeatherBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.wb_sunny, color: Colors.amber, size: 18),
          SizedBox(width: 8),
          Text('22°C • Calm Sea', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

/// ---------------- QUICK ACTIONS ----------------
class _QuickActions extends StatelessWidget {
  final VoidCallback onMapTap;
  final VoidCallback onWeatherTap;

  const _QuickActions({required this.onMapTap, required this.onWeatherTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(icon: Icons.map, label: 'Map', onTap: onMapTap),
        const SizedBox(width: 16),
        _ActionButton(icon: Icons.cloud, label: 'Weather', onTap: onWeatherTap),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.cyanAccent, size: 26),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

/// ---------------- CHAT INPUT BAR ----------------
class _ChatInputBar extends StatelessWidget {
  final VoidCallback onSend;

  const _ChatInputBar({required this.onSend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.white70),
            const SizedBox(width: 10),
            Icon(Icons.mic, color: Colors.white70),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Ask BlueGuide...',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: onSend,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.cyanAccent, Colors.blueAccent],
                  ),
                ),
                child: const Icon(Icons.arrow_upward, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
