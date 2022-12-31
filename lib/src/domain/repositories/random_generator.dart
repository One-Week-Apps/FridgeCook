import 'package:fridge_cook/src/domain/entities/move.dart';

abstract class RandomGenerator {
  List<Move> rand(List<Move> moves);
}