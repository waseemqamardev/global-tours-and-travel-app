import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Createpackage extends StatefulWidget {
  @override
  _CreatepackageState createState() => _CreatepackageState();
}

class _CreatepackageState extends State<Createpackage> {
  final _formKey = GlobalKey<FormState>();
  final Cname = TextEditingController();
  final City = TextEditingController();
  final Desc = TextEditingController();
  final Days = TextEditingController();

  final Distance = TextEditingController();
  final Price = TextEditingController();
  final auth=FirebaseAuth.instance;

  final firebase = FirebaseFirestore.instance.collection("Packages");


  create() async {
    try {
      String id=DateTime.now().millisecondsSinceEpoch.toString();
      await firebase.doc(id).set({
        "Cname": Cname.text.trim(),
        "City": City.text.trim(),
        "Description":Desc.text.trim(),
        "Days":Days.text.trim(),
        "Distance":Distance.text.trim(),
        "Price":Price.text.trim(),
        "id":id,

      }).then((value) {
        Fluttertoast.showToast(
          msg: 'Package submitted successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
        );
      });
    } catch (e) {
      print(e);
    }
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
        title: Text('Create Packages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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

                        create();

                      }
                    },
                    child: Text('Submit', style: TextStyle(
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



