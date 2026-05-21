import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withOpacity(0.5),
                          blurRadius: 20, spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('🧠', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Memory Match',
                      style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5)),
                  const SizedBox(height: 8),
                  Text('Find all matching pairs to win!',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white54)),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _statBox('20', 'Cards'),
                      const SizedBox(width: 16),
                      _statBox('10', 'Pairs'),
                      const SizedBox(width: 16),
                      _statBox('4×5', 'Grid'),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _previewGrid(),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GameScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('Play Now',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'CS5450 Mobile Programming • Lakehead University',
                    style: GoogleFonts.poppins(
                        fontSize: 11, color: Colors.white30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statBox(String value, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.white12),
    ),
    child: Column(
      children: [
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 11, color: Colors.white54)),
      ],
    ),
  );

  Widget _previewGrid() {
    const emojis = ['🐶', '?', '🐱', '?', '?', '🐸', '?', '?'];
    const colors = [
      Color(0xFF6C5CE7), Color(0xFFE17055), Color(0xFF00B894),
      Color(0xFF0984E3), Color(0xFFE84393), Color(0xFFFDAB1A),
      Color(0xFF00CEC9), Color(0xFFD63031),
    ];
    return SizedBox(
      width: 200, height: 100,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemCount: 8,
        itemBuilder: (_, i) {
          final open = emojis[i] != '?';
          return Container(
            decoration: BoxDecoration(
              color: open ? Colors.white : colors[i],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(emojis[i],
                  style: TextStyle(
                    fontSize: open ? 18 : 14,
                    color: open ? null : Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          );
        },
      ),
    );
  }
}