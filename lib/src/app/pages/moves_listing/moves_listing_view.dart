import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/app/pages/moves_details/moves_details_view.dart';
import 'package:fridge_cook/src/data/repositories/data_moves_repository.dart';
import 'package:fridge_cook/src/domain/entities/achievement_types.dart';
import 'package:fridge_cook/src/domain/entities/move.dart';
import 'package:fridge_cook/src/domain/usecases/achievements_observer.dart';

import '../achievements/achievements_view.dart';
import 'moves_listing_controller.dart';

class MovesListingRoute extends View {
  static const routeName = '/movesListing';
  final AchievementsObserver achievementsObserver;
  MovesListingRoute(this.achievementsObserver, {Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MovesListingRouteState createState() => _MovesListingRouteState();
}

class _MovesListingRouteState extends ViewState<MovesListingRoute, MovesListingController>
    with SingleTickerProviderStateMixin {
    _MovesListingRouteState()
      : super(MovesListingController(DataMovesRepository()));

  Widget _refreshMovesButton() {
    var controller = FlutterCleanArchitecture.getController<MovesListingController>(context);
    return FloatingActionButton(
      heroTag: "refreshMovesButton",
      backgroundColor: Colors.black,
      onPressed: () {
        this.widget.achievementsObserver.update(AchievementTypes.refresher);
        controller.flushMovesButtonPressed();
      },
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.refresh),
    );
  }

  Widget _moveTableViewCell(int index, Move item) {
    var controller = FlutterCleanArchitecture.getController<MovesListingController>(context);
    var move = controller.moves[index];
    print("move[${index.toString()}] = $move");
    var thumbnailWidth = MediaQuery.of(context).size.width - 100;
    var thumbnail = Image.network(move.thumbnailUrlString, width: thumbnailWidth, height: thumbnailWidth * 360 / 480);

    return InkWell(
                child: Container(
                  width: 356,
                  height: 500,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      thumbnail,
                      Row(
                        children: <Widget>[
                          Text('\n' + move.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                          Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                  move.isLiked ? CustomImages.like : CustomImages.dislike,
                  width: 20,
                  height: 20,
                )
              ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Difficulty: ${move.difficulty} over 5",
                            textAlign: TextAlign.left,
                          )),
                      Text(" "),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          move.description.substring(0, min(200, move.description.length - 1)) + "...\n"))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    MovesDetailsRoute.routeName,
                    arguments: move
                  );
                },
              );
  }

  Widget _ratePerformanceButton() {
    var controller = FlutterCleanArchitecture.getController<MovesListingController>(context);
    return FloatingActionButton(
      heroTag: "ratePerformanceButton",
      backgroundColor: Colors.black,
      onPressed: () {
        controller.ratePerformanceButtonPressed(context);
      },
      tooltip: 'Flush Salsa Moves',
      child: Icon(Icons.done),
    );
  }

  var _doOnce = true;
  @override
  Widget get view => buildPage();

  Widget buildPage() {
    var controller = FlutterCleanArchitecture.getController<MovesListingController>(context);

    if (_doOnce) {
      _doOnce = false;
      controller.getAllMoves();
    }

    var children = <Widget>[
      for (var i = 0 ; i < controller.moves.length ; i++) _moveTableViewCell(i, controller.moves[i])
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Container(width: 200, padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[_refreshMovesButton(), SizedBox(width: 5), _ratePerformanceButton()]),
      ),
      appBar: AppBar(
        title: Text(
          'Fridge Cook',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(CustomImages.trophy),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementsRoute()),
              );
            },
          )
        ],
      ),
      body: Center(
        child:
            ListView(
                padding: const EdgeInsets.all(8)
                    .add(EdgeInsets.only(top: 100))
                    .add(EdgeInsets.only(bottom: 50)),
                children: children,
      ),),
    );
  }

}
