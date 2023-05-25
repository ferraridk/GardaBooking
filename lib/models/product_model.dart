import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String city;
  final bool isApartment;
  final bool isCamping;
  final bool isSummerhouse;


  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    required this.city,
    required this.isApartment,
    required this.isCamping,
    required this.isSummerhouse,
  });

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrl,
    price,
    isRecommended,
    isPopular,
    city,
    isApartment,
    isCamping,
    isSummerhouse,
  ];

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Product(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      isRecommended: data['isRecommended'] as bool? ?? false,
      isPopular: data['isPopular'] as bool? ?? false,
      city: data['city'] ?? '',
      isApartment: data['isApartment'] as bool? ?? false,
      isCamping: data['isCamping'] as bool? ?? false,
      isSummerhouse: data['isSummerhouse'] as bool? ?? false,
    );
  }


  static List<Product> products = [
    Product(
      name: 'Lejlighed1',
      category: 'Lejligheder',
      imageUrl:
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=780&q=80',
      price: 134.0,
      isRecommended: true,
      isPopular: false,
      city: 'Limone',
      isApartment: true,
      isCamping: false,
      isSummerhouse: false,
    ),
    Product(
      name: 'Lejlighed2',
      category: 'Lejligheder',
      imageUrl:
      'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      price: 134.0,
      isRecommended: true,
      isPopular: true,
      city: 'Gargnano',
      isApartment: true,
      isCamping: false,
      isSummerhouse: false,
    ),
    Product(
      name: 'Lejlighed3',
      category: 'Lejligheder',
      imageUrl:
      'https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80',
      price: 134.0,
      isRecommended: false,
      isPopular: true,
      city: 'Toscolano Maderno',
      isApartment: true,
      isCamping: false,
      isSummerhouse: false,
    ),
    Product(
      name: 'Camping1',
      category: 'Camping',
      imageUrl:
      'https://images.unsplash.com/photo-1621872315260-d29289474c0a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      price: 134.0,
      isRecommended: true,
      isPopular: true,
      city: 'Moniga',
      isApartment: false,
      isCamping: true,
      isSummerhouse: false,
    ),
    Product(
      name: 'Camping2',
      category: 'Camping',
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/06/17/19/20/holiday-1463951_960_720.jpg',
      price: 134.0,
      isRecommended: true,
      isPopular: false,
      city: 'Desenzano',
      isApartment: false,
      isCamping: true,
      isSummerhouse: false,
    ),
    Product(
      name: 'Camping3',
      category: 'Camping',
      imageUrl:
      'https://cdn.pixabay.com/photo/2017/08/27/16/24/camping-2686641_960_720.jpg',
      price: 134.0,
      isRecommended: true,
      isPopular: false,
      city: 'Peschiera',
      isApartment: false,
      isCamping: true,
      isSummerhouse: false,

    ),
    Product(
      name: 'Sommerhus1',
      category: 'Sommerhuse',
      imageUrl:
      'https://cdn.pixabay.com/photo/2015/09/16/22/12/lake-garda-943493_960_720.jpg',
      price: 134.0,
      isRecommended: true,
      isPopular: false,
      city: 'Bardolino',
      isApartment: false,
      isCamping: false,
      isSummerhouse: true,
    ),
    Product(
      name: 'Sommerhus2',
      category: 'Sommerhuse',
      imageUrl:
      'https://cdn.pixabay.com/photo/2022/01/31/18/10/lake-6984727_960_720.jpg',
      price: 134.0,
      isRecommended: true,
      isPopular: true,
      city: 'Garda',
      isApartment: false,
      isCamping: false,
      isSummerhouse: true,
    ),
    Product(
      name: 'Sommerhus3',
      category: 'Sommerhuse',
      imageUrl:
      'https://cdn.pixabay.com/photo/2020/03/10/06/18/garda-4917940_960_720.jpg',
      price: 134.0,
      isRecommended: false,
      isPopular: true,
      city: 'Riva del garda',
      isApartment: false,
      isCamping: false,
      isSummerhouse: true,
    ),
  ];
}