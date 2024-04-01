import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('images').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic>? imageData = snapshot.data!.docs[index].data() as Map<String, dynamic>?;
                if (imageData == null) {
                  return Container(); // Handle null data
                }
                return ImageCard(
                  imageUrl: imageData['imageUrl'] ?? '',
                  name: imageData['name'] ?? '',
                  place: imageData['place'] ?? '',
                  description: imageData['description'] ?? '',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String place;
  final String description;

  const ImageCard({
    required this.imageUrl,
    required this.name,
    required this.place,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(place),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
