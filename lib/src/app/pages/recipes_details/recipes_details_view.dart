import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

class RecipesDetailsRoute extends StatefulWidget {
  static const routeName = '/recipesDetails';
  final Recipe recipe;

  RecipesDetailsRoute(this.recipe);

  @override
  State<StatefulWidget> createState() {
    return ProductsDetailsState();
  }
}

class ProductsDetailsState extends State<RecipesDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    var recipe = this.widget.recipe;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product Details',
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
                            Spacer(flex: 1,),
                        Text(recipe.name,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Difficulty: over 5",
                          textAlign: TextAlign.left,
                      )
                    ),
                    Text(" "),
                    Text(recipe.name),
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
                Image.network(recipe.name),
                Image.asset(CustomImages.play),
              ]),
              onTap: () {}
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
