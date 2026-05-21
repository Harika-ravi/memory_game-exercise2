import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card_model.dart';

// 20 distinct vibrant colors — one per card position
const _backs = [
  Color(0xFF6C5CE7), Color(0xFFE17055), Color(0xFF00B894),
  Color(0xFF0984E3), Color(0xFFE84393), Color(0xFFFDAB1A),
  Color(0xFF00CEC9), Color(0xFFD63031), Color(0xFF74B9FF),
  Color(0xFFA29BFE), Color(0xFF55EFC4), Color(0xFFFF7675),
  Color(0xFF6D9886), Color(0xFFF8A5C2), Color(0xFF778CA3),
  Color(0xFFE77F67), Color(0xFF786FA6), Color(0xFF3DC1D3),
  Color(0xFFEA8685), Color(0xFF596275),
];

class MemoryCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback onTap;
  const MemoryCard({super.key, required this.card, required this.onTap});

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    if (widget.card.isFaceUp) _ctrl.value = 1;
  }

  @override
  void didUpdateWidget(MemoryCard old) {
    super.didUpdateWidget(old);
    if (widget.card.isFaceUp != old.card.isFaceUp) {
      widget.card.isFaceUp ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final back = _backs[widget.card.colorIndex % _backs.length];
    return GestureDetector(
      onTap: widget.card.isMatched ? null : widget.onTap,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final angle = _anim.value * pi;
          final showFront = angle > pi / 2;
          final tilt = showFront ? angle - pi : angle;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(tilt),
            child: _CardFace(
              showFront: showFront,
              card: widget.card,
              backColor: back,
            ),
          );
        },
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  final bool showFront;
  final CardModel card;
  final Color backColor;

  const _CardFace({
    required this.showFront,
    required this.card,
    required this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        gradient: showFront
            ? null
            : LinearGradient(
          colors: [
            backColor,
            backColor.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: showFront
            ? (card.isMatched ? const Color(0xFFDFF9EB) : Colors.white)
            : null,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: card.isMatched
              ? const Color(0xFF00B894)
              : showFront
              ? const Color(0xFFDDDDDD)
              : backColor.withOpacity(0.5),
          width: card.isMatched ? 2.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: card.isMatched
                ? const Color(0xFF00B894).withOpacity(0.4)
                : backColor.withOpacity(showFront ? 0.1 : 0.4),
            blurRadius: card.isMatched ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: showFront ? _front() : _back(),
    );
  }

  Widget _front() => LayoutBuilder(
    builder: (context, constraints) {
      final emojiSize = constraints.maxHeight * 0.48;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.emoji,
            style: TextStyle(fontSize: emojiSize.clamp(20.0, 44.0)),
          ),
          SizedBox(height: constraints.maxHeight * 0.04),
          Text(
            card.label,
            style: TextStyle(
              fontSize: (constraints.maxHeight * 0.11).clamp(8.0, 13.0),
              fontWeight: FontWeight.w700,
              color: card.isMatched
                  ? const Color(0xFF00B894)
                  : const Color(0xFF444444),
            ),
          ),
        ],
      );
    },
  );

  Widget _back() => LayoutBuilder(
    builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '?',
            style: TextStyle(
              fontSize: (constraints.maxHeight * 0.38).clamp(18.0, 36.0),
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}