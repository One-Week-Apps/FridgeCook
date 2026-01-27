import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';

/// Unit Tests for ProductQuantity Value Object
///
/// ProductQuantity encapsulates the business rule that product quantities
/// must be between 1 and 9 (inclusive).
void main() {
  group('ProductQuantity Value Object', () {
    group('valid quantities', () {
      test('should accept quantity 1 (minimum)', () {
        final quantity = ProductQuantity(1);
        expect(quantity.value, equals(1));
      });

      test('should accept quantity 5 (middle value)', () {
        final quantity = ProductQuantity(5);
        expect(quantity.value, equals(5));
      });

      test('should accept quantity 9 (maximum)', () {
        final quantity = ProductQuantity(9);
        expect(quantity.value, equals(9));
      });
    });

    group('invalid quantities', () {
      test('should reject quantity 0', () {
        expect(
          () => ProductQuantity(0),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Quantity must be between 1 and 9'),
          )),
        );
      });

      test('should reject negative quantities', () {
        expect(
          () => ProductQuantity(-1),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Quantity must be between 1 and 9'),
          )),
        );

        expect(
          () => ProductQuantity(-100),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Quantity must be between 1 and 9'),
          )),
        );
      });

      test('should reject quantity greater than 9', () {
        expect(
          () => ProductQuantity(10),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Quantity must be between 1 and 9'),
          )),
        );

        expect(
          () => ProductQuantity(100),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Quantity must be between 1 and 9'),
          )),
        );
      });
    });

    group('Tell Don\'t Ask behavior', () {
      test('increment should return new ProductQuantity with increased value', () {
        final quantity = ProductQuantity(5);
        final incremented = quantity.increment();
        expect(incremented.value, equals(6));
        // Original should be unchanged (immutable)
        expect(quantity.value, equals(5));
      });

      test('increment should throw when already at maximum (9)', () {
        final quantity = ProductQuantity(9);
        expect(
          () => quantity.increment(),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Cannot increment'),
          )),
        );
      });

      test('decrement should return new ProductQuantity with decreased value', () {
        final quantity = ProductQuantity(5);
        final decremented = quantity.decrement();
        expect(decremented.value, equals(4));
        // Original should be unchanged (immutable)
        expect(quantity.value, equals(5));
      });

      test('decrement should throw when already at minimum (1)', () {
        final quantity = ProductQuantity(1);
        expect(
          () => quantity.decrement(),
          throwsA(isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('Cannot decrement'),
          )),
        );
      });

      test('canIncrement should return true when below maximum', () {
        expect(ProductQuantity(1).canIncrement, isTrue);
        expect(ProductQuantity(8).canIncrement, isTrue);
      });

      test('canIncrement should return false when at maximum', () {
        expect(ProductQuantity(9).canIncrement, isFalse);
      });

      test('canDecrement should return true when above minimum', () {
        expect(ProductQuantity(2).canDecrement, isTrue);
        expect(ProductQuantity(9).canDecrement, isTrue);
      });

      test('canDecrement should return false when at minimum', () {
        expect(ProductQuantity(1).canDecrement, isFalse);
      });
    });

    group('equality', () {
      test('two ProductQuantity with same value should be equal', () {
        final q1 = ProductQuantity(5);
        final q2 = ProductQuantity(5);
        expect(q1, equals(q2));
        expect(q1.hashCode, equals(q2.hashCode));
      });

      test('two ProductQuantity with different values should not be equal', () {
        final q1 = ProductQuantity(5);
        final q2 = ProductQuantity(6);
        expect(q1, isNot(equals(q2)));
      });
    });

    group('JSON serialization', () {
      test('toJson should return integer value', () {
        final quantity = ProductQuantity(5);
        expect(quantity.toJson(), equals(5));
      });

      test('fromJson should create ProductQuantity from integer', () {
        final quantity = ProductQuantity.fromJson(5);
        expect(quantity.value, equals(5));
      });

      test('fromJson should throw for invalid value', () {
        expect(
          () => ProductQuantity.fromJson(0),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => ProductQuantity.fromJson(10),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
  });
}
