class CardModel {
  final int pairId;
  final String emoji;
  final String label;
  final int colorIndex;  // ← NEW: based on position not pair
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.pairId,
    required this.emoji,
    required this.label,
    required this.colorIndex,
    this.isFaceUp = false,
    this.isMatched = false,
  });

  CardModel copyWith({bool? isFaceUp, bool? isMatched}) => CardModel(
    pairId: pairId,
    emoji: emoji,
    label: label,
    colorIndex: colorIndex,
    isFaceUp: isFaceUp ?? this.isFaceUp,
    isMatched: isMatched ?? this.isMatched,
  );
}