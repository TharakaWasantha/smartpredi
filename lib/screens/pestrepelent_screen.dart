import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:agrogenicprl/utils/radar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PestRepellent extends StatefulWidget {
  const PestRepellent({Key? key}) : super(key: key);

  @override
  State<PestRepellent> createState() => _PestRepellentState();
}

class _PestRepellentState extends State<PestRepellent> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Pest_Repellent/Destination');
  final reference = FirebaseDatabase.instance.ref('Pest_Repellent1/PIR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
        child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFfce2e1), Colors.white]),
        ),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: SafeArea(
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Pest-Repellent",

                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                        minRadius: 16,
                        backgroundImage: AssetImage("assets/pest.png"))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Automated repellent service ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Image(
                                      image: AssetImage('assets/pestrepellent.PNG'),
                                      fit: BoxFit.fill,
                                      height: 100,
                                      width: 200,
                                    ),
                                  ),
                                  Text(
                                    "Radar Navigation",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.home,size: 35,color: Colors.deepOrange,),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                                  },
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.logout,size: 35,color: Colors.red,),
                                    onPressed: () {
                                  SystemNavigator.pop();
                                }
                                ),),],
                          ),
                       Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          Container(
                            width: 250,
                            height: 250,
                            child: Radar
                            ( radarRange: 25,enemySize: 30,
                          ),),

                    ],
                  ),
                ),



                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                ),
                                color: Colors.blue,
                              ),
                              child: FirebaseAnimatedList
                                (query: ref, itemBuilder: (context, snapshot, animation, index)
                              {
                                return ListTile(
                                  title: Text("Distance to detected object : "+ snapshot.child('Range').value.toString()+" cm", style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                );
                              }),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                ),
                                color: Colors.yellow,
                              ),
                              child: FirebaseAnimatedList
                                (query: reference, itemBuilder: (context, snapshot, animation, index)
                              {
                                return ListTile(
                                  title: Text("PIR Status : "+ snapshot.child('Status').value.toString(), style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),),
                                );
                              }),
                            ),

                          ),

                  ]),
                  ))
          ),
                  ],
            ),
          ),
        ),
      ),
        ),
        ),
    );

  }
}
