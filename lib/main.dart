import 'package:ecomrejsegarda/blocs/cart/cart_bloc.dart';
import 'package:ecomrejsegarda/blocs/checkout/checkout_bloc.dart';
import 'package:ecomrejsegarda/blocs/product/product_bloc.dart';
import 'package:ecomrejsegarda/blocs/wishlist_bloc.dart';
import 'package:ecomrejsegarda/config/app_router.dart';
import 'package:ecomrejsegarda/cubits/login_cubit.dart';
import 'package:ecomrejsegarda/repositories/auth_repository.dart';
import 'package:ecomrejsegarda/repositories/checkout/checkout_repository.dart';
import 'package:ecomrejsegarda/repositories/product/product_repository.dart';
import 'package:ecomrejsegarda/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WishlistBloc>(
            create: (_) => WishlistBloc()..add(StartWishlist()),
          ),
          BlocProvider<CartBloc>(
            create: (_) => CartBloc()..add(CartStarted()),
          ),
          BlocProvider<CheckoutBloc>(
            create: (context) => CheckoutBloc(
              cartBloc: context.read<CartBloc>(),
              checkoutRepository: CheckoutRepository(),
            ),
          ),
          BlocProvider<ProductBloc>(
            create: (_) => ProductBloc(
              productRepository: ProductRepository(),
            )..add(LoadProducts()),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'GardaBooking',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
