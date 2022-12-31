import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/data/repositories/data_liked_moves_gateway.dart';
import 'package:fridge_cook/src/domain/entities/achievement_types.dart';
import 'package:fridge_cook/src/domain/entities/move.dart';
import 'package:fridge_cook/src/domain/usecases/achievements_observer.dart';
//import 'package:url_launcher/url_launcher.dart';

class MovesDetailsRoute extends StatefulWidget {
  static const routeName = '/movesDetails';
  final AchievementsObserver achievementsObserver;
  final Move move;

  MovesDetailsRoute(this.achievementsObserver, this.move);

  @override
  State<StatefulWidget> createState() {
    return MovesDetailsState();
  }
}

class MovesDetailsState extends State<MovesDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    var likedMovesGateway = DataLikedMovesGateway();
    var move = this.widget.move;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Move Details',
          style: GoogleFonts.salsa(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
                        height: MediaQuery.of(context).size.height + 50,
                        child: Column(children: <Widget>[
            Container(
      child: Container(
          padding: EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(move.name,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                        Spacer(
                          flex: 1,
                        ),
                        IconButton(
                            icon: Image.asset(
                              move.isLiked
                                  ? CustomImages.like
                                  : CustomImages.dislike,
                              width: 20,
                              height: 20,
                            ),
                            onPressed: () {
                              move.isLiked = !move.isLiked;
                              if (move.isLiked) {
                                this.widget.achievementsObserver.update(AchievementTypes.numberOfLikes);
                              }
                              setState(() {});
                              likedMovesGateway.setLikedMove(
                                  move, move.isLiked);
                            })
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Difficulty: ${move.difficulty} over 5",
                          textAlign: TextAlign.left,
                        )),
                    Text(" "),
                    Text(move.description),
                  ]))
            ],
          ),
      ),
            ),
            Spacer(
      flex: 10,
            ),
            Container(
      alignment: Alignment.bottomCenter,
      child: InkWell(
          child: InkWell(
              child: Stack(alignment: Alignment.center, children: [
                Image.network(move.thumbnailUrlString),
                Image.asset(CustomImages.play),
              ]),
              onTap: () { /*launch(move.urlString);*/ this.widget.achievementsObserver.update(AchievementTypes.videoLearner); }
            ),
      ),
            ),
            Spacer(
              flex: MediaQuery.of(context).size.height == 640 ? 1 : 15,
            ),
          ]),
        ),
        ),
    );
  }
}
