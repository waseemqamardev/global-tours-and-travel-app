class Hotel {
  String imageUrl;
  String name;
  String address;

  Hotel({
   required this.imageUrl,
    required this.name,
    required this.address,

  });
}

final List<Hotel> hotels = [
  Hotel(
    imageUrl: 'assets/hotel0.jpg',
    name: 'Hotel',
    address: '404 Great St',

  ),

  Hotel(
    imageUrl: 'assets/mountains.jpeg',
    name: 'Mountains',
    address: '404 Great St',

  ),
  Hotel(
    imageUrl: 'assets/deserts.jpeg',
    name: 'Desert',
    address: '404 Great St',

  ),
  Hotel(
    imageUrl: 'assets/forests.jpeg',
    name: 'Forest',
    address: '404 Great St',

  ),
];
