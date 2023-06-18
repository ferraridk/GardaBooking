import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecomrejsegarda/models/models.dart';
import 'package:equatable/equatable.dart';

import '../../models/cart_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());


  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    } else if (event is CartProductAdded) {
      yield* _mapCartProductAddedToState(event, state);
    } else if (event is CartProductRemoved) {
      yield* _mapCartProductRemovedToState(event, state);
    }
  }

  Stream<CartState> _mapCartStartedToState() async* {
    yield CartLoading();
    try {
      await Future<void>.delayed(Duration(seconds: 1));
      final fromDate = DateTime.now();
      final toDate = DateTime.now();
      print('fromDate: $fromDate, toDate: $toDate');
      yield CartLoaded(
        cart: Cart(
          fromDate: fromDate,
          toDate: toDate,
        ),
      );
    } catch (_) {
      yield CartError();
    }
  }

  Stream<CartState> _mapCartProductAddedToState(
      CartProductAdded event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..add(event.product),
            fromDate: state.cart.fromDate,
            toDate: state.cart.toDate,
          ),
        );
      } catch (_) {
        yield CartError();
      }
    }
  }

  Stream<CartState> _mapCartProductRemovedToState(
      CartProductRemoved event, CartState state) async* {
    if (state is CartLoaded) {
      try {
        yield CartLoaded(
          cart: Cart(
            products: List.from(state.cart.products)..remove(event.product),
            fromDate: state.cart.fromDate,
            toDate: state.cart.toDate,
          ),
        );
      } catch (_) {
        yield CartError();
      }
    }
  }
}
