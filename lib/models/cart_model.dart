import 'package:equatable/equatable.dart';
import 'product_model.dart';

class Cart extends Equatable {
  final List<Product> products;
  final DateTime? fromDate;
  final DateTime? toDate;
  final double totalPrice;

  const Cart({
    this.products = const <Product>[],
    this.fromDate,
    this.toDate,
    this.totalPrice = 0,
  });

  double get total {
    return calculateTotalPrice(fromDate, toDate);
  }

  DateTime? get selectedFromDate {
    return fromDate;
  }

  DateTime? get selectedToDate {
    return toDate;
  }


  double calculateTotalPrice(DateTime? fromDate, DateTime? toDate) {
    if (fromDate != null && toDate != null) {
      int numberOfDays = calculateNumberOfDays(fromDate, toDate);
      double totalPrice = products.fold(
        0,
            (total, current) => total + (current.price * numberOfDays),
      );
      return totalPrice;
    } else {
      return 0.0;
    }
  }

  int calculateNumberOfDays(DateTime fromDate, DateTime toDate) {
    return toDate.difference(fromDate).inDays;
  }

  String get totalPriceString => totalPrice.toStringAsFixed(2);

  @override
  List<Object?> get props => [products, fromDate, toDate];
}
