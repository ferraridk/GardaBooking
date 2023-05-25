import 'package:flutter/material.dart';

import '../models/models.dart';
import 'widgets.dart';


class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final String? selectedCity;

  const ProductCarousel({
    Key? key,
    required this.products,
    this.selectedCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = selectedCity != null
        ? products.where((product) => product.city == selectedCity).toList()
        : products;

    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: ProductCard(
                product: filteredProducts[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

