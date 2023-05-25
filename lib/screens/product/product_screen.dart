import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomrejsegarda/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/wishlist_bloc.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProductScreen(product: product),
    );
  }

  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(AddWishlistProduct(product));

                      final snackBar = SnackBar(
                          content: Text('Tilføjet til favorit listen!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(CartProductAdded(product));
                      Navigator.pushNamed(context, '/cart');


                      final snackBar = SnackBar(
                          content: Text('Tilføjet til Kurven!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Tilføj til indkøbskurven',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: false,
              ),
              items: [
                HeroCarouselCard(
                  product: product,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black.withAlpha(50),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 60,
                    color: Colors.blue.withAlpha(50),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            '${product.price},- Per dag',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.white,
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(
                    'Information Om Stedet',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel risus dictum, ultrices leo sed, ultricies mi. Quisque fermentum dolor nulla, ut dignissim leo porttitor sed. Morbi dignissim nisl felis, id lacinia neque tincidunt pretium. Maecenas facilisis hendrerit ipsum a porttitor. Maecenas pharetra lectus sem, quis finibus elit rutrum id. Nunc luctus risus sit amet sem hendrerit blandit. In dictum ultricies interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur varius tortor ipsum, in egestas sapien sodales nec.',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'Praktisk Information',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus vel risus dictum, ultrices leo sed, ultricies mi. Quisque fermentum dolor nulla, ut dignissim leo porttitor sed. Morbi dignissim nisl felis, id lacinia neque tincidunt pretium. Maecenas facilisis hendrerit ipsum a porttitor. Maecenas pharetra lectus sem, quis finibus elit rutrum id. Nunc luctus risus sit amet sem hendrerit blandit. In dictum ultricies interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur varius tortor ipsum, in egestas sapien sodales nec.',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
