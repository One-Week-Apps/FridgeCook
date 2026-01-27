/// ProductQuantity is a value object that encapsulates the business rule
/// that product quantities must be between 1 and 9 (inclusive).
///
/// This follows the Tell Don't Ask principle - validation is performed
/// internally, and the object provides methods to safely modify the value.
class ProductQuantity {
  static const int minQuantity = 1;
  static const int maxQuantity = 9;

  final int value;

  /// Creates a ProductQuantity with validation.
  ///
  /// Throws [ArgumentError] if value is not between 1 and 9 (inclusive).
  ProductQuantity(this.value) {
    if (value < minQuantity || value > maxQuantity) {
      throw ArgumentError(
        'Quantity must be between $minQuantity and $maxQuantity. Got: $value',
      );
    }
  }

  /// Creates a ProductQuantity from a JSON value (integer).
  ///
  /// Throws [ArgumentError] if value is not between 1 and 9 (inclusive).
  factory ProductQuantity.fromJson(int value) {
    return ProductQuantity(value);
  }

  /// Converts to JSON (integer value).
  int toJson() => value;

  /// Returns true if the quantity can be incremented (not at maximum).
  bool get canIncrement => value < maxQuantity;

  /// Returns true if the quantity can be decremented (not at minimum).
  bool get canDecrement => value > minQuantity;

  /// Returns a new ProductQuantity with the value incremented by 1.
  ///
  /// Throws [ArgumentError] if already at maximum (9).
  ProductQuantity increment() {
    if (!canIncrement) {
      throw ArgumentError(
        'Cannot increment: quantity is already at maximum ($maxQuantity)',
      );
    }
    return ProductQuantity(value + 1);
  }

  /// Returns a new ProductQuantity with the value decremented by 1.
  ///
  /// Throws [ArgumentError] if already at minimum (1).
  ProductQuantity decrement() {
    if (!canDecrement) {
      throw ArgumentError(
        'Cannot decrement: quantity is already at minimum ($minQuantity)',
      );
    }
    return ProductQuantity(value - 1);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductQuantity && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ProductQuantity($value)';
}
