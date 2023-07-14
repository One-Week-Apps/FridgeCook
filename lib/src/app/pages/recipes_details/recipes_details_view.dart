import 'package:flutter/material.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
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

  var grey = Color.fromARGB(153, 71, 72, 71);

  Widget _makeIngredient(String ingredient) {
    return Padding(padding: EdgeInsets.only(left: 5, right: 5), child: Container(width: 86, height: 112, padding: EdgeInsets.only(left: 4, top: 24, right: 4, bottom: 10), decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color.fromARGB(18, 223, 0, 27),),
                    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        spreadRadius: 14,
        blurRadius: 30,
        offset: Offset(10, 10), // changes position of shadow
      ),
    ],
                    borderRadius: BorderRadius.all(Radius.circular(14))), child: Column(children: [ImageIcon(AssetImage(CustomImages.food)), SizedBox(height: 14,), Text(ingredient, overflow: TextOverflow.ellipsis, style: GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 13, color: grey.withOpacity(0.96)),), SizedBox(height: 5,), Text("", style: GoogleFonts.dmSans(fontWeight: FontWeight.w500, fontSize: 12, color: Color.fromARGB(255, 163, 163, 163)),)])),);
  }

  Widget _makeDirection(int index, String direction, BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
      
      Container(alignment: Alignment.center, width: 33, height: 33, decoration: BoxDecoration(
                    color: Color.fromARGB(18, 223, 0, 27),
                    border: Border.all(color: Color.fromARGB(18, 223, 0, 27),),
                    borderRadius: BorderRadius.all(Radius.circular(10))), child: Text((index + 1).toString() + '', textAlign: TextAlign.center, style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 223, 0, 27)))),
                    
      SizedBox(width: 14,),
      
      Container(padding: EdgeInsets.only(top: 10), color: Colors.transparent, height: 50, width: MediaQuery.of(context).size.width - 75, child: Text(
      direction,
      style: GoogleFonts.dmSans(backgroundColor: grey, fontSize: 14, fontWeight: FontWeight.w500, color: grey))

    )]));
  }

  static Widget makeRecipeSpecifications() {
    var grey = Color.fromARGB(153, 71, 72, 71);

    return Row(children: [
                      ImageIcon(AssetImage(CustomImages.clock), color: grey,),
                      Text("Rapido",  style: GoogleFonts.dmSans(
                                fontSize: 14, fontWeight: FontWeight.w500, color: grey),),
                      SizedBox(width: 18),
                      ImageIcon(AssetImage(CustomImages.people), color: grey,),
                      Text("1 Serving", style: GoogleFonts.dmSans(
                                fontSize: 14, fontWeight: FontWeight.w500, color: grey),),
                      SizedBox(width: 18),
                      ImageIcon(AssetImage(CustomImages.difficulty), color: Colors.grey,),
                      Text("Easy", style: GoogleFonts.dmSans(
                                fontSize: 14, fontWeight: FontWeight.w500, color: grey),),
                    ]);
  }

  @override
  Widget build(BuildContext context) {
    var recipe = this.widget.recipe;

    return Scaffold(
      floatingActionButton: Container(padding: EdgeInsets.all(32), child: 
      
      
      
      Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
                    color: Color.fromARGB(77, 0, 0, 0),
                    borderRadius: BorderRadius.circular(28)
                  ),
          child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },),
        ),
      
      
      
      
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: SizedBox(
                        height: MediaQuery.of(context).size.height * 2,
                        child: Column(children: <Widget>[
            Container(
      child: Container(
          padding: EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 14, top: 0, right: 14),
                  child: Column(children: <Widget>[

Transform.translate(
          offset: Offset(0, -25), child:

                    Container(
                      width: MediaQuery.of(context).size.width * 0.93, height: MediaQuery.of(context).size.height * 0.60,
                      decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(recipe.image), fit: BoxFit.contain),//Image.network(recipe.image, width: 348, height: 312,)
                      color: Colors.white,
                      border: Border.all(color: Color.fromARGB(31, 255, 255, 255),),
                      borderRadius: BorderRadius.all(Radius.circular(35))
                    ), child: Text("")),

),

                    SizedBox(height: 0,),
                    Align(alignment: Alignment.centerLeft, child: Text(recipe.name,
                            style: GoogleFonts.dmSans(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                    SizedBox(height: 12,),
                    makeRecipeSpecifications(),
                    SizedBox(height: 30,),
                    Align(alignment: Alignment.centerLeft, child: Text("Ingredients", textAlign: TextAlign.left, style: GoogleFonts.dmSans(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(height: 9,),
                    SingleChildScrollView(clipBehavior: Clip.none, scrollDirection: Axis.horizontal, child: 
                    Row(children: [
                      for (var ingredient in recipe.ingredients)
                      _makeIngredient(ingredient),
                      ],)),
                    SizedBox(height: 30,),
                    Align(alignment: Alignment.centerLeft, child: Text("Instructions", style: GoogleFonts.dmSans(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    SizedBox(height: 10,),
                    Column(children: [
                      for (var i = 0; i < recipe.directions.length; i++) 
                      _makeDirection(i, recipe.directions[i], context)],),
                  ]))
            ],
          ),
      ),
            ),
            Spacer(
              flex: 10,
            ),
          ]),
        ),
        ),
    );
  }
}
