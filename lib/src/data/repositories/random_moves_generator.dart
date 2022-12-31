import 'package:fridge_cook/src/domain/entities/move.dart';
import 'package:fridge_cook/src/domain/repositories/random_generator.dart';

class RandomMovesGenerator implements RandomGenerator {
  
  @override
  List<Move> rand(List<Move> moves) {
    return moves.toList()..shuffle();
  }

}