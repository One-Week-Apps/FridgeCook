import '../entities/move.dart';

abstract class MovesRepository {
  Future<List<Move>> getAllMoves();
}
