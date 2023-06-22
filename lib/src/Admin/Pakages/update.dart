import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePackage extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> initialData;

  UpdatePackage({required this.docId, required this.initialData});

  @override
  _UpdatePackageState createState() => _UpdatePackageState();
}

class _UpdatePackageState extends State<UpdatePackage> {
  final _formKey = GlobalKey<FormState>();
  final Cname = TextEditingController();
  final City = TextEditingController();
  final Desc = TextEditingController();
  final Days = TextEditingController();
  final Distance = TextEditingController();
  final Price = TextEditingController();
  final auth=FirebaseAuth.instance;

  final firebase = FirebaseFirestore.instance.collection("Packages");


  // update() async {
  //   try {
  //     await firebase.doc(docId).update({
  //       "Cname": Cname.text.trim(),
  //       "City": City.text.trim(),
  //       "Description":Desc.text.trim(),
  //       "Days":Days.text.trim(),
  //       "Distance":Distance.text.trim(),
  //       "Price":Price.text.trim(),
  //
  //
  //     }).then((value) {
  //       Fluttertoast.showToast(
  //         msg: 'Package submitted successfully',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.grey[800],
  //         textColor: Colors.white,
  //       );
  //     });
  //   } catch (e) {
  //     print(e);
  //

  void updatePackageData() {
    String cname = Cname.text.trim();
    String city = City.text.trim();
    String desc = Desc.text.trim();
    String days = Days.text.trim();
    String distance = Distance.text.trim();
    String price = Price.text.trim();

    // Perform the update operation using the Firestore instance and document ID
    FirebaseFirestore.instance.collection('Packages').doc(widget.docId).update({
      'Cname': cname,
      'City': city,
      'Description': desc,
      'Days': days,
      'Distance': distance,
      'Price': price,
    }).then((_) {
      Fluttertoast.showToast(
        msg: 'Package updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the initial data
    Cname.text = widget.initialData['Cname'];
    City.text = widget.initialData['City'];
    Desc.text = widget.initialData['Description'];
    Days.text = widget.initialData['Days'];
    Distance.text = widget.initialData['Distance'];
    Price.text = widget.initialData['Price'];
  }

  @override
  void dispose() {
    Cname.dispose();
    City.dispose();
    Desc.dispose();
    Days.dispose();
    Distance.dispose();
    Price.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Update Pakages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: City,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Cname,
                decoration: InputDecoration(labelText: 'Country Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a country name';
                  }
                  return null;
                },

              ),

              TextFormField(
                controller: Desc,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Days,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Days'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of days';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Distance,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Distance'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the distance';
                  }
                  return null;
                },

              ),

              SizedBox(height: 16.0),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: TextButton(

                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        updatePackageData();

                      }
                    },
                    child: Text('Update', style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik Regular',
                        color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



