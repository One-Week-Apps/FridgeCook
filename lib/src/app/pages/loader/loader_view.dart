import 'package:flutter/material.dart';
import 'package:fridge_cook/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';

class LoaderRoute extends StatelessWidget {
  static const routeName = '/loader';
  final String title;
  final String description;

  LoaderRoute(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    var title = this.title;
    var description = this.description;

    var processingView = Lottie.asset(
        'assets/animations/Processing.json', width: 200, height: 200,);
    
    var titleStyle = GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
    var descriptionStyle = GoogleFonts.dmSans(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white);

    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //leadingWidth: 100,
        centerTitle: true,
        titleSpacing: 0,
        leading: Transform.translate(
    offset: Offset(MediaQuery.of(context).size.width / 2 - 150, 4),
    child: ImageIcon(AssetImage(CustomImages.logo), color: Colors.white,)),
        title: Text('FridgeCook', style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),)
      ),
      body: Padding(padding: EdgeInsets.all(38), child: Center(
        child:
          PageView(
            children: <Widget>[

              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                makeLoaderImage(CustomImages.cooking, context),
                Spacer(flex: 2),
                Text(title, textAlign: TextAlign.center, style: titleStyle,),
                Spacer(flex: 2),
                Text(description, textAlign: TextAlign.center, style: descriptionStyle,),
                Spacer(flex: 2),
                processingView,
                Spacer(flex: 2),
              ]),


            ],
          )
          )),
    );
  }

  Widget makeLoaderImage(String name, BuildContext context) {
    var imageHeight = 190.0;

    return Ink.image(
        fit: BoxFit.fitHeight,
        height: imageHeight,
        image: AssetImage(
          name
        ));
  }
}