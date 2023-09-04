import 'dart:async';

class Strings {
  static const String addToCart = 'Add to cart';
  static const String title = 'DEALBERG';
  static const String cart = 'Cart';
  static const String search = 'Search';
  static const String notAvailable = 'This Product is not available';
  static const String product = 'product';
  static const String productName = 'productName';
  static const String price = 'price';
  static const String description = 'description';
  static const String id = 'id';
  static const String quantity = 'quantity';
  static const String image = 'image';
  static const String api = '64f30ce8edfa0459f6c63c41.mockapi.io';
  static const String path = '/products';
  static const String apiError = 'Api Error';
}

List cartQun = [];
double totalAmt = 0;
int totalThi = 0;
final StreamController<int> counterController = StreamController<int>();

List image = [
  'https://snooplay.in/cdn/shop/products/SupercarresemblingBugatti-AssortedColours1_1800x1800.png?v=1645262484',
  'https://www.superherotoystore.com/cdn/shop/products/AAFL1188AAFQ218-1_1200x.jpg?v=1667625063',
  'https://4.imimg.com/data4/SU/GM/MY-16231031/rc-bugatti-veyron-car-500x500.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyhzIqGADVpTo7U072YfSR9P8BEytQUd3D4FFZGBZPcjIuaZIGlReMhZA8xgsRqxUztbA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzbx1lehv8pJDKGnVxojmu_p8jDwU3m1CaeqtW0hhcI5Pm-0h25vo-uSfbeH2wB-uMPxQ&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVqW_xuwacF2VZQBbUuVVnumkjOVPo0eeKG5m0wlXwQsPunj1Qo1k4DlrzRiK3niSFhdw&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREjOpgBEqU-ZURT3lLtxc9bP56vUHF3theXPYqNWlCPOZmuMiDPz3xLY_JKm39tJdsqeg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwvR2_QYIEIBH2Wkp8WTZ7NAaPr7c7fWqqoh8QreuHunX1r84Fo3fjglzEQOezt8dqbmE&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBzGBeW8lTCswUGDlYfB2O8U64kfraY4bmdlkn8ZqUltLRUrqTyQvwlceLUxN3mMcQcLo&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBzGBeW8lTCswUGDlYfB2O8U64kfraY4bmdlkn8ZqUltLRUrqTyQvwlceLUxN3mMcQcLo&usqp=CAU',
  'https://media.istockphoto.com/id/622248826/video/crash-of-two-toy-cars-on-a-road.jpg?s=640x640&k=20&c=Y6Fo2IUj5uWgIC0hGGPW7nDZig3h_ZTQzqZmLeS2xiQ='
];
