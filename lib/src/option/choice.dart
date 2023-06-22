import 'package:flutter/material.dart';

import '../../Authentication/Admin auth/Agent.dart';
import '../../Authentication/user autt/UserLogin.dart';






class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/paris.jpg'),
                      fit: BoxFit.contain,

                    )


                ),
              ),
            ),

            Column(
              children:[   Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:Theme.of(context).primaryColor,
                ),
                child:  Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin ()));
                    },
                    child: Text(
                      "Login as an Admin",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik Regular',
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
      SizedBox(height: 20,),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:Theme.of(context).primaryColor,
                  ),
                  child:  Center(
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Userlogin()));
                      },
                      child: Text(
                        "Login as a User",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Rubik Regular',
                            color: Colors.white),
                      ),
                    ),

                  ),
                ),


    ],
            )
          ],
        ),
      ),
    );
  }
}
