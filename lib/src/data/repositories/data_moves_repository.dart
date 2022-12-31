import '../../domain/entities/move.dart';

import '../../domain/repositories/moves_repository.dart';

class DataMovesRepository extends MovesRepository {
  List<Move> moves;
  static DataMovesRepository _instance = DataMovesRepository._internal();
  DataMovesRepository._internal() {
    moves = <Move>[];
    moves.addAll([
      Move('Sombrero', 'Key Times: 1 * 8', '''Begins with: From Open Position, Vacilala con la Mano (right hand)

Hand holds: Right hand to Right hand, Left hand grabs Right hand, Followers Left arm ends on Leaders Left shoulder keeping the hand holds 

Ends with: “crossed hand ending”, like in El Uno.''', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
      Move('El Uno', 'Key Times: 3 * 8', '''Begins with: Open Position, Guapea, Right hand to Left hand
      
Hand holds: Right hand to Left hand, then pull Followers right arm behind her back twice, then enshufela arms on top twice

Ends with: bounce effect, Sombrero end position''', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
      Move('El Dos', 'Key Times: 4 * 8', '''Begins with: Open Position, enshufela
      
Hand holds: Right hand to Left hand, then Leader pulls Follower behind his back twice, then enshufela arms on top twice

Ends with: Sombrero''', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
      Move('Montana', 'Key Times: 3 * 8', '''Begins with: same as Sombrero, from Open Position, Vacilala con la Mano (right hand)
      
Hand holds: Right hand to Right hand, Left hand grabs Right hand, end arms crossed Leaders left arm on top, pull with enshufela to end arms crossed Leaders right arm on top, leader right turn arms on top

Ends with: bounce effect, di le que no''', 'https://www.youtube.com/embed/A8MCYkUZRXk', 2),
      Move('Coca Cola', 'Key Times: 2 * 8', '''Begins with: Enshufela then di le que no
      
Hand holds: while doing di le que no, place Left arm in front of Followers on Right shoulder and pull

Ends with: Move back to reach di le que no's position and end with di le que no''', 'https://www.youtube.com/embed/C8N58KGoGyw', 2),
      Move('Kentucky', 'Key Times: 2 * 8', '''Begins with: Closed Position
      
Hand holds: Enshufela by pulling left hand, right arm ends behind Followers, change positions again Left hand ends behind Followers still holding right hand, Leader right turn

Ends with: Di le que no''', 'https://www.youtube.com/embed/6CXoxcQ3bAk', 2),
      Move('Tour Magico', 'Key Times: 1 * 8', '''Begins with: Closed Position
      
Hand holds: Closed hand holding, then Followers right turn, then Leaders left turn

Ends with: Closed position''', 'https://www.youtube.com/embed/mG_J0xQy8O8', 2),
      Move('Vacilala Vacilense', 'Key Times: 1 * 8', '''Begins with: Open Position
      
Hand holds: Left hand to Right hand, pull and release the hand to indicate Followers to perform Right turn

Ends with: Di le que no''', 'https://www.youtube.com/embed/Obl71WOOjJ4', 2),
      Move('Enchufela Doble', 'Key Times: 2 * 8', '''Begins with: Open or Closed position, Left hand to Right hand
      
Hand holds: Left hand to Right hand, pull to change positions but Leaders put Right arm behind Followers back and then pushes, perform twice

Ends with: Closed Position''', 'https://www.youtube.com/embed/r2KcM4wxOC4', 2),
      Move('Exhibela Doble', 'Key Times: 2 * 8', '''Begins with: Closed Position
      
Hand holds: Leaders lifts up its left arm then pushes followers back with Right hand, then Leaders pull left to go back in closed position 

Ends with: Closed Position''', 'https://www.youtube.com/embed/o4nkV-0Ts9Q', 2),
    ]);
  }
  factory DataMovesRepository() => _instance;

  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }
}
