import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: 10, // Assuming you have a list of wishlist items
        itemBuilder: (context, index) {
          return PropertyListItem(
            imageUrl: 'https://via.placeholder.com/150', // Example image URL
            title: 'Property Title $index',
            location: 'Location $index',
            price: '\$100', // Example price
            onAddToTrip: () {
              // Handle adding property to the trip
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Property added to the trip')),
              );
            },
          );
        },
      ),
    );
  }
}

class PropertyListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String price;
  final VoidCallback onAddToTrip;

  const PropertyListItem({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.onAddToTrip,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location),
          Text(price),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: onAddToTrip,
      ),
    );
  }
}
