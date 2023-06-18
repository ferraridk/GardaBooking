import 'package:ecomrejsegarda/blocs/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {


  static const String routeName = '/checkout';

  static Route route() { // Modtag totalprisen som en parameter
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CheckoutScreen(
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(title: 'Bekræft oplysninger'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {},
                child: Text(
                  'BEKRÆFT KØB',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KUNDE INFORMATIONER',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  _buildTextFormField(emailController, context, 'Email'),
                  _buildTextFormField(nameController, context, 'Fulde Navn'),
                  _buildTextFormField(addressController, context, 'Addresse'),
                  _buildTextFormField(cityController, context, 'By'),
                  _buildTextFormField(countryController, context, 'Land'),
                  _buildTextFormField(zipCodeController, context, 'Postnummer'),
                  SizedBox(height: 20),
                  Text(
                    'OPHOLD INFORMATIONER',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pris:',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        '\Kr.${state.cart.totalPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.displayMedium,
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


  Widget _buildTextFormField(
      TextEditingController controller,
      BuildContext context,
      String labelText,
      ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}