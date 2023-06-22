import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:global/src/Admin/Pakages/Create.dart';
import 'package:global/src/Admin/Pakages/ui.dart';
import 'package:global/src/option/choice.dart';


import 'Booking Request.dart';

class Adminpanel extends StatefulWidget {
  const Adminpanel({Key? key}) : super(key: key);

  @override
  State<Adminpanel> createState() => _AdminpanelState();
}

class _AdminpanelState extends State<Adminpanel> {
  Future<int> fetchRegisteredUsersCount() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Users data').get();
    return snapshot.docs.length; // Return the length of the document snapshot list
  }
  Future<int> fetchPackageCount() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Packages').get();
    return snapshot.docs.length; // Return the length of the document snapshot list
  }
  Future<int> fetchBookingCount() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Booking').get();
    return snapshot.docs.length; // Return the length of the document snapshot list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Admin Panel"),
        actions: [
          IconButton(
            onPressed:
                () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor:   Theme.of(context).primaryColor,
                    title: Center(child: Text("ALERT")),
                    content: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Are u sure want to logout"),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then((value) {

Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ChoiceScreen()), (route) => false);
                            }).onError((error, stackTrace) {
                              print(error);
                            });
                          },
                          child: Text(
                            "yes",
                            style: TextStyle(   color: Theme.of(context).colorScheme.secondary,),
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
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("Admin@gmail.com"),
              currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset("assets/waseem.jpg"),
                  )),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                image: DecorationImage(
                    image: AssetImage("assets/travel.jpg"), fit: BoxFit.cover),
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(

                title: Text(
                  "Dashboard",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminpanel()));
                },
              ),
            ),
            Card(
              color:Theme.of(context).primaryColor,
              child: ListTile(

                title: Text(
                  "Create Packages",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Createpackage()));
                },
              ),
            ),
            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(

                title: Text(
                  "Packages",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Packages()));
                },
              ),
            ),


            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(

                title: Text(
                  "Booking Request",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Booking()));
                },
              ),
            ),



            Card(
              color: Theme.of(context).primaryColor,
              child: ListTile(

                title: Text(
                  "Signout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:   Theme.of(context).primaryColor,
                        title: Center(child: Text("ALERT")),
                        content: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("Are u sure want to logout"),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ChoiceScreen()), (route) => false);

                                }).onError((error, stackTrace) {
                                  print(error);
                                });
                              },
                              child: Text(
                                "yes",
                                style: TextStyle(   color: Theme.of(context).colorScheme.secondary,),
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
              ),
            ),
          ]),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: fetchRegisteredUsersCount(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    }
    if (!snapshot.hasData) {
    return Center(child: Text('No registered users found'));
    }

    int userCount = snapshot.data!;

    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(10)
                ),
               
                child: Center(
                child: Text('Users: $userCount', style: TextStyle(color: Colors.black,fontSize: 20),),

                ),
              ),
            ],
          ),
    );
    }
          ),
          SizedBox(height: 20,),
          FutureBuilder<int>(
              future: fetchPackageCount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No Package found'));
                }

                int Packagecount = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Center(
                          child: Text('Total Packages: $Packagecount',style: TextStyle(color: Colors.black,fontSize: 20),),

                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
          SizedBox(height: 20,),
          FutureBuilder<int>(
              future: fetchBookingCount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No Package found'));
                }

                int Packagecount = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Center(
                          child: Text('Total Booking: $Packagecount',style: TextStyle(color: Colors.black,fontSize: 20),),

                        ),
                      ),
                    ],
                  ),
                );
              }
          ),

        ],
      )
    );
  }
}
