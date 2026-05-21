import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../widgets/memory_card.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameState(),
      child: const _GameBody(),
    );
  }
}

class _GameBody extends StatelessWidget {
  const _GameBody();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameState>();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          _AppHeader(game: game),
          _ScoreBar(game: game),
          Expanded(
            child: game.won
                ? _WinScreen(game: game)
                : _CardGrid(game: game),
          ),
          _BottomBar(game: game),
        ],
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────
class _AppHeader extends StatelessWidget {
  final GameState game;
  const _AppHeader({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
            ),
          ),
          Row(
            children: [
              const Text('🧠', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                'Memory Match',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined,
                    color: Colors.white, size: 14),
                const SizedBox(width: 4),
                Text(
                  game.clock,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Score bar ─────────────────────────────────────────────────────────────────
class _ScoreBar extends StatelessWidget {
  final GameState game;
  const _ScoreBar({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF16213E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stat('🎯', 'Moves', '${game.moves}'),
          Container(height: 36, width: 1, color: Colors.white12),
          _stat('✅', 'Matched', '${game.matches}/${game.total}'),
          Container(height: 36, width: 1, color: Colors.white12),
          _stat('📦', 'Left', '${game.total - game.matches}'),
        ],
      ),
    );
  }

  Widget _stat(String icon, String label, String value) => Column(
    children: [
      Text(
        '$icon $label',
        style: GoogleFonts.poppins(fontSize: 11, color: Colors.white54),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  );
}

// ── Card grid — responsive ────────────────────────────────────────────────────
class _CardGrid extends StatelessWidget {
  final GameState game;
  const _CardGrid({required this.game});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    // On wider screens (Windows/Web) cards should be more square
    final ratio = screenW > 600 ? 0.95 : 0.82;

    return Padding(
      padding: EdgeInsets.all(screenW > 600 ? 24 : 12),
      child: GridView.builder(
        itemCount: game.cards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: screenW > 600 ? 14 : 10,
          crossAxisSpacing: screenW > 600 ? 14 : 10,
          childAspectRatio: ratio,
        ),
        itemBuilder: (_, i) => MemoryCard(
          card: game.cards[i],
          onTap: () => game.flip(i),
        ),
      ),
    );
  }
}

// ── Win screen ────────────────────────────────────────────────────────────────
class _WinScreen extends StatelessWidget {
  final GameState game;
  const _WinScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withOpacity(0.2),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 8),
              Text(
                'You Won!',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'All ${game.total} pairs found!',
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Result cards
              Row(
                children: [
                  _resultCard('⏱', 'Time', game.clock,
                      const Color(0xFF6C5CE7)),
                  const SizedBox(width: 10),
                  _resultCard('🎯', 'Moves', '${game.moves}',
                      const Color(0xFFE17055)),
                  const SizedBox(width: 10),
                  _resultCard('🏆', 'Score', game.starRating,
                      const Color(0xFF00B894)),
                ],
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => game.restart(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'Play Again 🎮',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultCard(
      String icon, String label, String value, Color color) =>
      Expanded(
        child: Container(
          padding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                    fontSize: 10, color: Colors.grey),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}

// ── Bottom bar ────────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final GameState game;
  const _BottomBar({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: TextButton.icon(
        onPressed: () => _confirmRestart(context),
        icon: const Icon(Icons.refresh_rounded,
            color: Color(0xFF6C5CE7), size: 20),
        label: Text(
          'Restart Game',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6C5CE7),
          ),
        ),
      ),
    );
  }

  void _confirmRestart(BuildContext context) {
    final game = context.read<GameState>();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text('Restart?',
            style:
            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('All progress will be lost.',
            style: GoogleFonts.poppins()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              game.restart();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7)),
            child: Text('Restart',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}