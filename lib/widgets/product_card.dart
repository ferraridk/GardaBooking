import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlisted;

  const ProductCard({
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishlisted = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: product,
        );
      },
      child: ClipRect(
        child: Container(
          width: MediaQuery.of(context).size.width / widthFactor,
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 0.40 * 150,
                    color: Colors.black.withAlpha(150),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'DKK ${product.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if(state is CartLoading){
                              return Center(child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CartLoaded) {
                              return Expanded(child: IconButton(
                                icon: Icon(Icons.add_circle, color: Colors.white),
                                onPressed: (){
                                  context.read<CartBloc>()
                                      .add(CartProductAdded(product));


                                  final snackBar = SnackBar(
                                      content: Text('Tilføjet til Kurven!'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                              ),
                              );
                            }
                            else {return Text('Noget gik galt!');
                            }
                          },
                        ),
                        isWishlisted
                            ? Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
