import '../entities/move.dart';

abstract class LikedMovesGateway {
  Future<bool> setLikedMove(Move move, bool isLiked);
  Future<bool> isLikedMove(Move move);
}
