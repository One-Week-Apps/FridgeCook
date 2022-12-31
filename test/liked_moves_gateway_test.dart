import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/data_liked_moves_gateway.dart';
import 'package:fridge_cook/src/domain/entities/move.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {

  var move = Move('Sombrero', 'Key Times: 4 * 4', 'The Sombrero move', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1);

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  test('Moves are disliked by default', () async {
    // var sut = DataLikedMovesGateway();

    // final SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.clear();

    // var isLiked = await sut.isLikedMove(move);

    // expect(isLiked, false);
  });

  test('Liked Move is liked', () async {
    // var sut = DataLikedMovesGateway();
  
    // await sut.setLikedMove(move, true);
    // var isLiked = await sut.isLikedMove(move);

    // expect(isLiked, true);
  });

  test('Disliked Move is disliked', () async {
    // var sut = DataLikedMovesGateway();

    // await sut.setLikedMove(move, false);
    // var isLiked = await sut.isLikedMove(move);

    // expect(isLiked, false);
  });

}
