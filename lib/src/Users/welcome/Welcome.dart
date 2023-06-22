import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global/src/Users/User%20profile/updateprofile.dart';
import 'package:global/src/option/choice.dart';

import 'package:global/widgets/desitination_courosal/destination_carousal.dart';
import 'package:global/widgets/hotels_carousal/hotel_carousel.dart';
import 'package:image_picker/image_picker.dart';



class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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

  final currentuser = FirebaseAuth.instance;

  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.personWalking,
    FontAwesomeIcons.personBiking,
  ];
  int _selectedIndex = 0;
  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).colorScheme.secondary
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  double height = 0;
  double width = 0;

  @override
  Widget build(BuildContext context) {
    print('current user id is $currentuser');
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Tours and Travels"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Theme.of(context).primaryColor,
                          title: Center(child: Text("ALERT")),
                          content: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Are u sure want to logout"),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ChoiceScreen()), (route) => false);
                                  }).onError((error, stackTrace) {
                                    print(error);
                                  });
                                },
                                child: Text(
                                  "yes",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "no",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ));
              },
              icon: Icon(Icons.supervised_user_circle_rounded),
            )
          ],
          centerTitle: true,
        ),
        drawer: Container(
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users data")
                      .where("uid", isEqualTo: currentuser.currentUser!.uid)
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
                                UserAccountsDrawerHeader(
                                  accountName: Text(
                                    data["name"],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  accountEmail: Text(
                                    data["email"],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  arrowColor: Colors.cyan,
                                  currentAccountPicture: Stack(
                                    children: [
                                      Container(
                                        width: 200,
                                        height: 200,
                                        child: StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                          stream: FirebaseFirestore.instance
                                              .collection("Users data")
                                              .doc(currentuser.currentUser!.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data != null) {
                                              final userData =
                                                  snapshot.data!.data();
                                              if (userData != null &&
                                                  userData
                                                      is Map<String, dynamic>) {
                                                final imageUrl = userData
                                                        .containsKey('imageurl')
                                                    ? userData['imageurl']
                                                        as String
                                                    : '';

                                                return CircleAvatar(
                                                  child: ClipOval(
                                                    child: imageUrl.isNotEmpty
                                                        ? Image.network(
                                                            imageUrl,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Placeholder(
                                                            child: Text(
                                                                'NO IMAGE'),
                                                            fallbackHeight: 200,
                                                            fallbackWidth: 200,
                                                          ),
                                                  ),
                                                );
                                              }
                                            }

                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        right: -15,
                                        top: -15,
                                        child: IconButton(
                                            onPressed: _pickImage,
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: 20,
                                              color: Colors.black,
                                            )),

                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/travel.jpg"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.perm_identity,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      data["name"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () => print("upload tapped"),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      data["country"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () => print("profile tapped"),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.phone_in_talk,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      data["phone"],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () => print("message tapped"),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.message_rounded,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "Chats",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () => print("Chats tapped"),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "notification",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () => print("notification tapped"),
                                  ),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                      leading: const Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "settings",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Updateprofile()));
                                      }),
                                ),
                                Card(
                                  color: Theme.of(context).primaryColor,
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "signout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                title: Center(
                                                    child: Text("ALERT")),
                                                content: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  child: Text(
                                                      "Are u sure want to logout"),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        await FirebaseAuth
                                                            .instance
                                                            .signOut()
                                                            .then((value) {
                                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ChoiceScreen()), (route) => false);
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(error);
                                                        });
                                                      },
                                                      child: Text(
                                                        "yes",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                        ),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "no",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ],
                                              ));
                                    },
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: SpinKitWave(
                          color: Colors.black, // Set the desired color
                          size: 150, // Set the desired size
                        ),
                      );

                    }
                  }),
            ]),
          ),
        ),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                "What would you like to find?",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            DestinalCarousal(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        )),
      ),
    );
  }
}
