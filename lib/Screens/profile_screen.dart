// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ProfilePage extends StatelessWidget {
//   final FirebaseStorage _storage =
//   FirebaseStorage.instanceFor(bucket: 'YOUR_FIREBASE_STORAGE_BUCKET');
//
//
//
//   Future<void> _uploadImage() async {
//     final picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//       String imageName = DateTime.now().millisecondsSinceEpoch.toString();
//       try {
//         await _storage.ref('profile_images/$imageName.png').putFile(imageFile);
//         // Upload successful, you may want to show a message or update UI
//       } on FirebaseException catch (e) {
//         // Error uploading image
//         print('Error uploading image to Firebase: $e');
//       }
//     } else {
//       // User canceled image picker
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Row(
//           children: [
//             const Expanded(
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Profile',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.notifications,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 // Add notification functionality
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 // Navigate to full profile page
//               },
//               child: const Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: AssetImage('assets/profile.jpg'),
//                         radius: 30,
//                       ),
//                       SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'John Doe',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               'john.doe@example.com',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.arrow_forward_ios),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _uploadImage, // Call the upload image function
//         tooltip: 'Upload Image',
//         child: Icon(Icons.file_upload),
//       ),
//
//     );
//   }
// }




import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseStorage _storage =
  FirebaseStorage.instanceFor(bucket: 'YOUR_FIREBASE_STORAGE_BUCKET');



  // Future<void> _uploadImage() async {
  //   final picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //     String imageName = DateTime.now().millisecondsSinceEpoch.toString();
  //     try {
  //       await _storage.ref('profile_images/$imageName.png').putFile(imageFile);
  //       // Upload successful, you may want to show a message or update UI
  //     } on FirebaseException catch (e) {
  //       // Error uploading image
  //       print('Error uploading image to Firebase: $e');
  //     }
  //   } else {
  //     // User canceled image picker
  //   }
  // }




  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        await _storage.ref('profile_images/$imageName.png').putFile(imageFile);
        // Upload successful, you may want to show a message or update UI
        print('Image uploaded successfully');
      } on FirebaseException catch (e) {
        // Error uploading image
        print('Error uploading image to Firebase: $e');
        if (e.code == 'unauthorized') {
          print('User does not have permission to upload to this reference.');
        }
        // Add more error handling as needed
      }
    } else {
      // User canceled image picker
      print('Image picker was canceled by the user.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                // Add notification functionality
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to full profile page
              },
              child: const Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'john.doe@example.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage, // Call the upload image function
        tooltip: 'Upload Image',
        child: Icon(Icons.file_upload),
      ),
    );
  }
}

