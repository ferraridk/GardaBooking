import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
import '../../repositories/checkout/checkout_repository.dart';
import '../cart/cart_bloc.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        _checkoutRepository = checkoutRepository,
        super(cartBloc.state is CartLoaded
          ? CheckoutLoaded(
        products: (cartBloc.state as CartLoaded).cart.products,
        total: (cartBloc.state as CartLoaded).cart.total.toString(),
        totalPrice: 0.0,
      )
          : CheckoutLoading()) {
    _cartSubscription = cartBloc.stream.listen((state) {
      if (state is CartLoaded) {
        add(UpdateCheckout(cart: state.cart));
      }
    });
  }

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is UpdateCheckout) {
      yield* _mapUpdateCheckoutToState(event, state);
    } else if (event is ConfirmCheckout) {
      yield* _mapConfirmCheckoutToState(event, state);
    } else if (event is SetTotalPrice) {
      yield* _mapSetTotalPriceToState(event, state);
    }
  }

  Stream<CheckoutState> _mapUpdateCheckoutToState(
      UpdateCheckout event,
      CheckoutState state,
      ) async* {
    if (state is CheckoutLoaded) {
      yield state.copyWith(
        email: event.email ?? state.email,
        fullName: event.fullName ?? state.fullName,
        products: event.cart?.products ?? state.products,
        total: event.cart?.total.toString() ?? state.total,
        address: event.address ?? state.address,
        city: event.city ?? state.city,
        country: event.country ?? state.country,
        zipCode: event.zipCode ?? state.zipCode,
      );
    }
  }

  Stream<CheckoutState> _mapConfirmCheckoutToState(
      ConfirmCheckout event,
      CheckoutState state,
      ) async* {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        yield CheckoutLoading();
      } catch (_) {
        // Handle error
      }
    }
  }

  Stream<CheckoutState> _mapSetTotalPriceToState(
      SetTotalPrice event,
      CheckoutState state,
      ) async* {
    if (state is CheckoutLoaded) {
      yield state.copyWith(totalPrice: event.totalPrice);
    }
  }


  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    _checkoutSubscription?.cancel();
    return super.close();
  }
}
