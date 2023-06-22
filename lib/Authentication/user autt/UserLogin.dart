
import 'package:flutter/material.dart';
import 'package:global/src/Users/navigationbar/BottomNav.dart';





import '../../Utils/Firebase.dart';
import 'SignUP.dart';

void main() {
  runApp(const Userlogin());
}

class Userlogin extends StatefulWidget {
  const Userlogin({Key? key}) : super(key: key);

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passcontroler = TextEditingController();
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
                      "User Login",
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
                            controller: emailcontroler,
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
                            decoration:  InputDecoration(
                                hintText: 'Email',
                                fillColor: const Color(0xffF8F9FA),
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color(0xff323F4B),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                                  borderRadius: BorderRadius.circular(10),
                                )

                            )
                        ),
                      ),



                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                      obscureText: _obscureText,
                      controller: passcontroler,
                      validator: (value) {
                        if (value!.length <= 7) {
                          return "password must be greater than 7";
                        }
                        return null;

                      },
                      decoration:  InputDecoration(
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
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_open,
                            color: Color(0xff323F4B),
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffE4E7EB)),
                            borderRadius: BorderRadius.circular(10),
                          )

                      )
                  ),
                ),

                const SizedBox(
                  height: 100,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     color:Theme.of(context).primaryColor,
                  ),
                  child:  Center(
                    child: TextButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          await FirebaseServices.login(emailcontroler.text.trim(), passcontroler.text.trim());
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => btmnavigation()));
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
                ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      " Dont have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: Color(0xff4C5980)),
                    ),
                    TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),));
                    },
                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik Medium',
                            color:Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
