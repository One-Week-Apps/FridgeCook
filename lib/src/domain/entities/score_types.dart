enum ScoreTypes {
  tempo,
  bodyMovement,
  tracing,
  hairBrushes,
  blocks,
  locks,
  handToss
}

extension ScoreTypesExtension on ScoreTypes {
  static const _names = {
    ScoreTypes.tempo: 'Tempo',
    ScoreTypes.bodyMovement: 'Body Movement',
    ScoreTypes.tracing: 'Tracing',
    ScoreTypes.hairBrushes: 'Hair Brushes',
    ScoreTypes.blocks: 'Blocks',
    ScoreTypes.locks: 'Locks',
    ScoreTypes.handToss: 'Hand Toss',
  };

  String get rawValue => _names[this];
}
