import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global/src/Admin/Pakages/update.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  double height=0;
  double width=0;
  final auth = FirebaseAuth.instance;
  final firebase =
  FirebaseFirestore.instance.collection("Booking").snapshots();
  void deleteData(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('Booking').doc(docId).delete();
      Fluttertoast.showToast(
          msg: 'Booking Cancel',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
      );
    } catch (error) {
      print('Error deleting data: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Booking Request"),

          centerTitle: true,
        ),

        body: Column(
          children: [


            StreamBuilder(
                stream: firebase,
                builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 700,
                        width: 400,
                        color: Theme.of(context).cardColor,
                        child: ListView.builder(
                            itemCount: data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: ((context, index) {

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Text(
                                        //   data[index]["Cname"].toString(),
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 26,
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   height: 12,
                                        // ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color(0xffd99156),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              data[index]["Cname"].toString(),
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "Name",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "${data[index]["Fullname"].toString()}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "Email ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "${data[index]["Email"].toString()}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "Phone number ",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Text(
                                              "${data[index]["Phone"].toString()}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),


                                        SizedBox(height: 15),
                                        Text(
                                          "Message",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          data[index]["Message"].toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Divider(
                                          height: 5,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color:Theme.of(context).primaryColor,
                                              ),
                                              child:  Center(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    Fluttertoast.showToast(
                                                        msg: 'Booking Accepted successfully',
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        backgroundColor: Colors.grey[800],
                                                        textColor: Colors.white,
                                                    );

                                                  },
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: 'Rubik Regular',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20,),
                                            Container(
                                              height: 50,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color:Theme.of(context).primaryColor,
                                              ),
                                              child:  Center(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    deleteData(data[index].id);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: 'Rubik Regular',
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              );

                            })),
                      ),
                    );
                  } else {
                    return Center(child: Text("no data"));
                  }
                })),

          ],

        ),
      ),
    );
  }
}
