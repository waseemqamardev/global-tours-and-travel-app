import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:global/src/Users/User%20profile/widgets/info.dart';
import 'package:image_picker/image_picker.dart';

// our data

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth currentUser = FirebaseAuth.instance;

  //--------------------------------imagepicker-------------------------

  File? _imageFile;
  String _uploadedImageUrl = '';

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _uploadImage();
      });
    }
  }

  // Function to upload profile image to storage and save image URL to Firestore
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      // Step 1: Upload the image to Firebase Storage
      final storage = FirebaseStorage.instance;
      final storageRef = storage
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() {});

      // Step 2: Get the uploaded image's URL
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await storageRef.getDownloadURL();

        // Step 3: Save the image URL to Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userCollectionRef =
              FirebaseFirestore.instance.collection('Users data');
          final currentUserDocRef = userCollectionRef.doc(user.uid);

          await currentUserDocRef.update({
            'imageurl': downloadUrl,
          });

          setState(() {
            _uploadedImageUrl = downloadUrl;
          });

          print("Image URL saved to Firestore");
        }
      }
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userCollectionRef =
            FirebaseFirestore.instance.collection('Users');
        final currentUserDocRef = userCollectionRef.doc(user.uid);

        final docSnapshot = await currentUserDocRef.get();
        if (docSnapshot.exists) {
          setState(() {
            imageUrl = docSnapshot.get('imageurl');
          });
        }
      }
    } catch (error) {
      print('Error loading profile image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 80),
          child: Column(children: <Widget>[
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users data")
                    .where("uid", isEqualTo: currentUser.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return Column(
                          children: [
                      Stack(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection("Users data")
                                  .doc(currentUser.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  final userData = snapshot.data!.data();
                                  if (userData != null &&
                                      userData is Map<String, dynamic>) {
                                    final imageUrl =
                                    userData.containsKey('imageurl')
                                        ? userData['imageurl'] as String
                                        : '';

                                    return Container(
                                      color: Colors.grey.shade50,

                                      child: CircleAvatar(
                                        child: ClipOval(

                                          child: imageUrl.isNotEmpty
                                              ? Image.network(imageUrl, fit: BoxFit.cover,)
                                              : Placeholder(
                                            child: Text('NO IMAGE'),
                                            fallbackHeight: 200,
                                            fallbackWidth: 200,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }

                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),

                          Positioned(
                        right: 20,
                            bottom:05,
                            child: IconButton(onPressed:_pickImage, icon: Icon(Icons.add_a_photo,size: 50,color: Colors.grey,)),
                            // child: Container(
                            //
                            //   decoration: BoxDecoration(
                            //     color: Colors.transparent,
                            //     border: Border.all(
                            //       color: Colors.green,
                            //       width: 2,
                            //     ),
                            //     borderRadius: BorderRadius.circular(30),
                            //   ),
                            //   child: InkWell(
                            //     onTap: _pickImage,
                            //     child: Center(child: Text('Pick Image')),
                            //   ),
                            // ),
                          ),

                        ],
                      ),      //     ),
                            //    ----------------------------------------------------------//

SizedBox(height: 20,),
                            Text(
                              data["name"],
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.blueGrey[200],
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                              height: 20,
                              width: 200,
                              child: Divider(
                                color: Colors.blueGrey[200],
                              ),
                            ),

                            // we will be creating a new widget name info carrd

                            InfoCard(
                                text: data["phone"],
                                icon: Icons.phone,
                                onPressed: () async {}),

                            InfoCard(
                                text: data["country"],
                                icon: Icons.location_city,
                                onPressed: () async {}),
                            InfoCard(
                                text: data["email"],
                                icon: Icons.email,
                                onPressed: () async {}),
                          ],
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ]),
        ));
  }
}
