// import 'package:flutter/material.dart';
//
// class BookingPage extends StatefulWidget {
//   @override
//   _BookingPageState createState() => _BookingPageState();
// }
//
// class _BookingPageState extends State<BookingPage> {
//   String _destination = '';
//   DateTime _startDate = DateTime.now();
//   DateTime _endDate = DateTime.now().add(Duration(days: 7));
//   String _name = '';
//   String _email = '';
//   String _phone = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book a Tour'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Destination'),
//             SizedBox(height: 8.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Enter a city or attraction name',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _destination = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             Text('Travel Dates'),
//             SizedBox(height: 8.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Start: ${_startDate.toLocal()}'.split(' ')[0]),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Select'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('End: ${_endDate.toLocal()}'.split(' ')[0]),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Select'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16.0),
//             Text('Contact Information'),
//             SizedBox(height: 8.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Full Name',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _name = value;
//                 });
//               },
//             ),
//             SizedBox(height: 8.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Email Address',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _email = value;
//                 });
//               },
//             ),
//             SizedBox(height: 8.0),
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Phone Number',
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _phone = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Book Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final Cname = TextEditingController();

  final Message = TextEditingController();
  final Fullname = TextEditingController();
  final Email = TextEditingController();
  final Phone = TextEditingController();
  final auth=FirebaseAuth.instance;

  final firebase = FirebaseFirestore.instance.collection("Booking");


  create() async {
    try {
      String id=DateTime.now().millisecondsSinceEpoch.toString();
      await firebase.doc(id).set({
        "Cname": Cname.text.trim(),

        "Message":Message.text.trim(),
        "Fullname":Fullname.text.trim(),
        "Email":Email.text.trim(),
        "Phone":Phone.text.trim(),
        "id":id,

      }).then((value) {
        Fluttertoast.showToast(
          msg: 'Booking Submitted Successfully',
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

  // @override
  // void dispose() {
  //   Cname.dispose();
  //   City.dispose();
  //   Desc.dispose();
  //   Days.dispose();
  //   Distance.dispose();
  //   Price.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Booking Packages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Destination'),
            SizedBox(height: 8.0),
              TextFormField(
                controller: Cname,
                decoration: InputDecoration(labelText: 'Place name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a country name';
                  }
                  return null;
                },

              ),
              SizedBox(height: 16.0),
              Text('Contact Information'),
              SizedBox(height: 8.0),


              TextFormField(
                controller:Fullname ,

                decoration: InputDecoration(labelText: 'Fullname'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the Ur name';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Phone,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(labelText: 'Phone',),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },

              ),
              TextFormField(
                controller: Email,

                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Ur email';
                  }
                  return null;
                },

              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: Message,

                decoration: InputDecoration(labelText: 'Message',),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Ur Message';
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




