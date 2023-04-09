import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_cook/src/domain/usecases/completions_request_formatter.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test('should format completion request correctly', () async {
    var sut = CompletionsRequestFormatter();

    var request = sut.format([
      Product(
        "Orange",
        1,
        "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg",
      ),
      Product(
        "Apple",
        1,
        "https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc=",
      ),
    ]);

    expect(request, "Give the name and the recipe using ingredients Orange, Apple.");
  });

}

