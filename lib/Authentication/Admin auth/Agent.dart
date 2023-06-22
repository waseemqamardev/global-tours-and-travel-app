import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:global/src/Admin/Adminpanel.dart';




class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final formkey = GlobalKey<FormState>();
  TextEditingController adminEmail = TextEditingController();
  TextEditingController adminPass = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      height: 100,
                      width: 100,
                      image: AssetImage('assets/travel.jpg'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Global Travel",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Rubik Regular',
                              color: Color(0xff203142)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "App",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Rubik Regular',
                                color: Color(0xffF9703B)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                    child: Text(
                  "Admin Login",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Rubik Medium',
                      color: Color(0xff203142)),
                )),
                const SizedBox(
                  height: 14,
                ),
                const Center(
                  child: Text(
                    "Lorem Ipsum has been the \n industry's standard dummy,",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik Regular',
                        color: Color(0xff4C5980)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            controller: adminEmail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is empty";
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return "Email is not valid";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email',
                                fillColor: const Color(0xffF8F9FA),
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xff323F4B),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                            obscureText: _obscureText,
                            controller: adminPass,
                            validator: (value) {
                              if (value!.length <= 7) {
                                return "password must be greater than 7";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'password',
                                fillColor: const Color(0xffF8F9FA),
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _obscureText = !_obscureText;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_open,
                                  color: Color(0xff323F4B),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff660099)),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      InkWell(
                        onTap: () {
                          print('111111111111111111111');
                          if (formkey.currentState!.validate()) {
                            if (adminEmail.text != "" && adminPass.text != "") {
                              print('1');
                              adminlogin(context,adminEmail,adminPass);
                            }
                          }

                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: TextButton(
                              onPressed: ()  {
                                print('2222222222222222222222222222222222222');
                                if (formkey.currentState!.validate()) {
                                  print("${adminEmail.text}");
                                  print("${adminPass.text}");
                                  if (adminEmail.text != "" && adminPass.text != "") {
                                    print('1');
                                     adminlogin(context,adminEmail,adminPass);
                                  }
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Rubik Regular',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> adminlogin(context,TextEditingController adminEmail,TextEditingController adminPass) async {
  String errorMessage = "";

  try {
    print('11');
    // await FirebaseFirestore.instance
    //     .collection("Admin")
    //     .doc("adminlogin")
    //     .snapshots()
    //     .forEach((element) {
    //       try{
    //         print('2224444');
    //         print('${element.data()!["adminEmail"]}');
    //         print('${element.data()!["adminPass"]}');
    //         if (element.data()?["adminEmail"] == adminEmail.text.trim() &&
    //             element.data()?["adminPass"] == adminPass.text.trim()) {
    //           print('2222');
    //           Fluttertoast.showToast(msg: "Admin login successfully:");
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => Adminpanel()),
    //                   (route) => false);
    //         }
    //       }catch(e){
    //         print(e.toString());
    //       }
    //
    // })
    //     .whenComplete(() {
    //   print('comleted');
    // })
    //     .catchError((e) {
    //   Fluttertoast.showToast(msg: e!.message);
    // });

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: adminEmail.text.trim(), password: adminPass.text.trim()).then((value) {

      Fluttertoast.showToast(msg: "Admin login successfully:");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Adminpanel()));

    });
  }  on FirebaseAuthException catch  (e) {
    print('Failed with error code: ${e.code}');
    Fluttertoast.showToast(msg: e.toString());

    print(e.message);
  }



}
