import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    var recipe = this.widget.recipe;//Recipe("Sample recipe", ["1 apple", "1 sugar"], ["Take an apple", "Take some sugar"], Image.network("https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc=", width: 200, height: 200), []);//this.widget.recipe;
    print("Building recipe: $recipe");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          recipe.name + ' 🧑‍🍳',
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
                    Image.network(recipe.image, width: 100, height: 100,),
                    // Spacer(),
                    Text(recipe.name,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                    Column(children: [for (var ingredient in recipe.ingredients) Text("\u2022 " + ingredient)],),
                    Column(children: [for (var i = 0; i < recipe.directions.length; i++) Text((i + 1).toString() + '. ' + recipe.directions[i])],),
                    // Spacer(flex: 1),
                    // Row(children: [ Text("Hey")/*for (var ingredient in recipe.ingredients) Text('\u2022 ' + ingredient)*/]),
                    // Spacer(
                    //   flex: 1
                    //   ),
                    // Row(children: [ for (var i = 0; i < recipe.directions.length; i++) Text(i.toString() + '. ' + recipe.directions[i])])
                  ]))
            ],
          ),
      ),
            ),
            Spacer(
              flex: 10,
            ),
      //       Container(
      // alignment: Alignment.bottomCenter,
      // child: InkWell(
      //     child: recipe.image,
      // ),
      //       ),
      //       Spacer(
      //         flex: MediaQuery.of(context).size.height == 640 ? 1 : 15,
      //       ),
          ]),
        ),
        ),
    );
  }
}
