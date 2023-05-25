import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String? selectedCity;

  HomeScreen({this.selectedCity});

  static const String routeName = '/home';

  static Route route({String? selectedCity}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(selectedCity: selectedCity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              CustomAppBar(
                title: selectedCity ?? 'GardaBooking',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: Text(
                          'Her ser du den valgte by. Vælg hvilke type ophold du ønsker.',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(15),
                        ),
                      ),
                      SectionTitle(title: 'Sommerhuse'),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProductLoaded) {
                            return ProductCarousel(
                              products: state.products
                                  .where((product) =>
                                      product.isSummerhouse &&
                                      (selectedCity == null ||
                                          product.city == selectedCity))
                                  .toList(),
                            );
                          }
                          return Text('Ukendt handling');
                        },
                      ),
                      SectionTitle(title: 'Lejligheder',),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProductLoaded) {
                            return ProductCarousel(
                              products: state.products
                                  .where((product) =>
                                      product.isApartment &&
                                      (selectedCity == null ||
                                          product.city == selectedCity))
                                  .toList(),
                            );
                          } else if (state is ProductError) {
                            // Handle the error state here
                            return Text('Error: ${state.error}');
                          } else {
                            return Text('Unknown state');
                          }
                        },
                      ),
                      SectionTitle(title: 'Camping'),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ProductLoaded) {
                            return ProductCarousel(
                              products: state.products
                                  .where((product) =>
                                      product.isCamping &&
                                      (selectedCity == null ||
                                          product.city == selectedCity))
                                  .toList(),
                            );
                          }
                          return Text('Ukendt Handling');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
