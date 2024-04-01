import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  PickedFile? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path) as PickedFile?; // Convert XFile to a File
      });
    }
  }



  Future<void> _uploadImage() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      // Upload image to Firebase Storage
      try {
        final String imageName = _imageFile!.path.split('/').last;
        final reference = FirebaseStorage.instance.ref().child('images/$imageName');
        final uploadTask = reference.putFile(File(_imageFile!.path));
        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Save image metadata to Firestore
        final imageData = {
          'name': _nameController.text,
          'place': _placeController.text,
          'description': _descriptionController.text,
          'imageUrl': downloadUrl,
        };
        await FirebaseFirestore.instance.collection('images').add(imageData);

        // Show success message or navigate to HomePage
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image uploaded successfully!'),
          ),
        );
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: ${error.message}'),
          ),
        );
      }
    }
  }

  Future<void> getLostData() async {
    final picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (!response.isEmpty) {
      final List<XFile>? files = response.files;
      if (files != null) {
        _handleLostFiles(files);
      } else {
        _handleError(response.exception as Object);
      }
    }
  }

  void _handleLostFiles(List<XFile> files) {
    // Handle lost files
  }

  void _handleError(Object error) {
    // Handle error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image selection button or preview
              _imageFile != null
                  ? (_imageFile!.path.startsWith('http') || _imageFile!.path.startsWith('https'))
                  ? CachedNetworkImage(
                imageUrl: _imageFile!.path,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
                  : Image.file(File(_imageFile!.path))
                  : ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: _placeController,
                decoration: InputDecoration(labelText: 'Place'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
