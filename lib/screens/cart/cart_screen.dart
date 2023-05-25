import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CartScreen(),
    );
  }

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DateTime? fromDate;
  DateTime? toDate;

  int get numberOfDays => toDate?.difference(fromDate!).inDays ?? 0;

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final selectedDates = await showDateRangePicker(
      context: context,
      firstDate: initialDate,
      lastDate: DateTime(initialDate.year + 1),
    );

    if (selectedDates != null) {
      setState(() {
        fromDate = selectedDates.start;
        toDate = selectedDates.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Indkøbskurven'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
                child: Text(
                  'Køb',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Her kan du købe dit ophold',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: state.cart.products.length,
                          itemBuilder: (context, index) {
                            return CartProductCard(
                              product: state.cart.products[index],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Vælg datoer',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  // Bottom GUI
                  Column(
                    children: [
                      Divider(thickness: 5),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Datoer valgt',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                '${fromDate != null ? DateFormat('MMM d').format(fromDate!) : '-'} - ${toDate != null ? DateFormat('MMM d').format(toDate!) : '-'}',
                                style: Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Antal dage',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            '$numberOfDays',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(50),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Pris',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    '\Kr.${state.cart.calculateTotalPrice(fromDate, toDate)}',
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Text('Noget gik galt!');
        },
      ),
    );
  }
}
