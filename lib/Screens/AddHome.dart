import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddHomePage extends StatefulWidget {
  const AddHomePage({Key? key}) : super(key: key);

  @override
  _AddHomePageState createState() => _AddHomePageState();
}

class _AddHomePageState extends State<AddHomePage> {
  File? _image;
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadImage(XFile imageFile) async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await _storage.ref('profile/$imageName.png').putFile(File(imageFile.path));
      // Upload successful, you may want to show a message or update UI
    } on FirebaseException catch (e) {
      // Error uploading image
      print('Error uploading image to Firebase: $e');
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _getLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (!response.isEmpty) {
      final List<XFile>? files = response.files;
      if (files != null) {
        _handleLostFiles(files);
      } else {
        _handleError(response.exception);
      }
    }
  }

  void _handleLostFiles(List<XFile> files) {
    // Handle lost image files here
  }

  void _handleError(Exception? exception) {
    // Handle error here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Listing'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _getImageFromCamera,
              icon: Icon(Icons.camera_alt),
              label: Text('Take a Photo'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Container()
                : Image.file(
              _image!,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  _uploadImage(_image! as XFile);
                } else {
                  _getLostData();
                }
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddHomePage(),
  ));
}
