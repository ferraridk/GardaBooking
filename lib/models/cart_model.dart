import 'package:equatable/equatable.dart';
import 'product_model.dart';

class Cart extends Equatable {
  final List<Product> products;
  final DateTime? fromDate;
  final DateTime? toDate;

  const Cart({
    this.products = const <Product>[],
    this.fromDate,
    this.toDate,
  });

  double get total {
    return calculateTotalPrice(fromDate, toDate);
  }

  String get totalString => total.toStringAsFixed(2);

  DateTime? get selectedFromDate {
    return fromDate;
  }

  DateTime? get selectedToDate {
    return toDate;
  }

  double calculateTotalPrice(DateTime? fromDate, DateTime? toDate) {
    if (fromDate != null && toDate != null) {
      int numberOfDays = toDate.difference(fromDate).inDays;
      double totalPrice = products.fold(
        0,
            (total, current) => total + (current.price * numberOfDays),
      );
      return totalPrice;
    } else {
      return 0.0;
    }
  }



  @override
  List<Object?> get props => [products, fromDate, toDate];
}
