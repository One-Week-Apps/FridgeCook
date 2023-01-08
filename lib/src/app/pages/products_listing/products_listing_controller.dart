import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/CustomImages.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/usecases/achievements_observer.dart';

import 'products_listing_presenter.dart';

import 'package:fridge_cook/main.dart';

class ProductsListingController extends Controller {
  int _counter;
  List<Product> _products;
  
  // data used by the View
  int get counter => _counter;
  List<Product> get products => _products;
  
  final ProductsListingPresenter presenter;
  // Presenter should always be initialized this way
  ProductsListingController(productsRepo)
      : _counter = 0,
        presenter = ProductsListingPresenter(productsRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {

    ProductsListingPresenter.getAllProductsOnNext = (List<Product> products) {
      print(products.toString());
      _products = products;
      refreshUI();
    };

    ProductsListingPresenter.addPerformanceOnNext = () {
      print('Performance added!');
    };

    ProductsListingPresenter.getPerformancesOnNext = (List<Performance> perfs) {
      print(perfs.toString());
      _performances = perfs;
      refreshUI();
    };
  }

  void getAllProducts() => ProductsListingPresenter.getAllProducts();
  void getAllPerformances() => ProductsListingPresenter.getAllPerformances();

  void flushProductsButtonPressed() {
    print("flushProductsButtonPressed");
    getAllProducts();
  }

  void ratePerformanceButtonPressed(BuildContext context) {
    print("ratePerformanceButtonPressed");
    showRatingDialog(context);
  }

  void updateAchievements() {
    AchievementsObserver achievementsObserver = CommonDeps().achievementsObserver;
    achievementsObserver.update(AchievementTypes.consecutiveDaysDancing);
    
    var difficulties = _products.map((e) => e.difficulty).toList();
    var oneStarCount = difficulties.where((element) => element == 1).toList().length;
    var twoStarCount = difficulties.where((element) => element == 2).toList().length;
    var threeStarCount = difficulties.where((element) => element == 3).toList().length;
    var fourStarCount = difficulties.where((element) => element == 4).toList().length;
    var fiveStarCount = difficulties.where((element) => element == 5).toList().length;
    
    for (int i = 0; i < oneStarCount; i++) {
      achievementsObserver.update(AchievementTypes.difficulty1);
    }
    for (int i = 0; i < twoStarCount; i++) {
      achievementsObserver.update(AchievementTypes.difficulty2);
    }
    for (int i = 0; i < threeStarCount; i++) {
      achievementsObserver.update(AchievementTypes.difficulty3);
    }
    for (int i = 0; i < fourStarCount; i++) {
      achievementsObserver.update(AchievementTypes.difficulty4);
    }
    for (int i = 0; i < fiveStarCount; i++) {
      achievementsObserver.update(AchievementTypes.difficulty5);
    }
  }

  void ratePerformanceValidated() {
    print("ratePerformanceValidated");
    var perfScore = PerformanceScore(
      _ratings[ScoreTypes.tempo],
      _ratings[ScoreTypes.bodyProductment],
      _ratings[ScoreTypes.tracing],
      _ratings[ScoreTypes.hairBrushes],
      _ratings[ScoreTypes.blocks],
      _ratings[ScoreTypes.locks],
      _ratings[ScoreTypes.handToss],
    );
    var datetime = DateTime.now();
    var perf = Performance(datetime.millisecondsSinceEpoch, perfScore, datetime);
    ProductsListingPresenter.addPerformance(perf);
    refreshUI();
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void onDisposed() {
    ProductsListingPresenter.dispose();
    super.onDisposed();
  }

  static var _ratingsKeys = ScoreTypes.values;
  static var _ratingsValues = List.filled(ScoreTypes.values.length, 3);
  Map<ScoreTypes, int> _ratings = new Map.fromIterables(_ratingsKeys, _ratingsValues);

  List<Widget> _starRatingView(ScoreTypes scoreType, StateSetter setState) {
    var children = <Widget>[
      for (var i = 0 ; i < 5 ; i++) new Container(
        width: 40,
        height: 40,
        child: IconButton(icon: new Image.asset(
            i < this._ratings[scoreType] ? CustomImages.starOn : CustomImages.starOff,
            fit: BoxFit.scaleDown,
          ), onPressed: () {
            print("${scoreType.rawValue} rated ${i + 1}");
            setState(() {
              this._ratings[scoreType] = (i + 1);
            });
          })
      )
    ];
    return children;
  }

  Widget _ratingBox(ScoreTypes scoreType) {
    String title = scoreType.rawValue;
    return Column(children: <Widget>[
      Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      StatefulBuilder(builder: (context, setState) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: _starRatingView(scoreType, setState));
      }),
    ]);
  }

  void showRatingDialog(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Dialog dialogWithImage = Dialog(
      child: Container(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.9,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                "Performance Self-Rating",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),

            // Rating Box
            Text("Rate your dance style \nto track your progress \nand earn achievements !", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Spacer(flex: 2),
            _ratingBox(ScoreTypes.tempo),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.bodyProductment),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.tracing),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.hairBrushes),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.blocks),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.locks),
            Spacer(flex: 1),
            _ratingBox(ScoreTypes.handToss),
            Spacer(flex: 2),

            // Confirm Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    this.updateAchievements();
                    this.ratePerformanceValidated();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                )
              ],
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => dialogWithImage);
  }
}
