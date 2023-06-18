part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? total;
  final double totalPrice;
  final Checkout checkout;

  CheckoutLoaded({
    this.fullName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.products,
    this.total,
    this.totalPrice = 0.0,
  }) : checkout = Checkout(
    fullName: fullName,
    email: email,
    address: address,
    city: city,
    country: country,
    zipCode: zipCode,
    products: products,
    total: total,
  );

  @override
  List<Object?> get props =>
      [fullName, email, address, city, country, zipCode, products, total, totalPrice];

  CheckoutLoaded copyWith({
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    List<Product>? products,
    String? total,
    double? totalPrice,
  }) {
    return CheckoutLoaded(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      products: products ?? this.products,
      total: total ?? this.total,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
