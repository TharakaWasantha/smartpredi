import 'package:agrogenicprl/screens/airventilation_screen.dart';
import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class air extends StatefulWidget {
  const air({Key? key}) : super(key: key);

  @override
  State<air> createState() => _airState();
}

class _airState extends State<air> with SingleTickerProviderStateMixin{

  late Animation<Color?> animation;
  late AnimationController controller;

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Air_Ventilation/Humidity');
  final reference = FirebaseDatabase.instance.ref('Air_Ventilation/Temperature');
  final reference2 = FirebaseDatabase.instance.ref('Air_Ventilation/Smoke');
  final reference3 = FirebaseDatabase.instance.ref('Air_Ventilation/LPG');

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation =
        ColorTween(begin: Colors.yellow, end: Colors.red).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Material(
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
                          "Air-Ventilation",

                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                            minRadius: 16,
                            backgroundImage: AssetImage("assets/temp.jpg"))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                                      height: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Automated Air-ventilation service ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Image(
                                                image: AssetImage('assets/airventiht.jpg'),
                                                fit: BoxFit.fill,
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                            Text(
                                              "Indoor Specific Navigation",
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Container(
                                                  color: animation.value,
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: ()
                                                      {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>  Airventilation()
                                                          ),);
                                                      },
                                                    child: const Text('Charts View -->', style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w900),),
                                                  ),
                                          ),
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
                                          (query: reference, itemBuilder: (context, snapshot, animation, index)
                                        {
                                          return ListTile(
                                            title: Text("Temperature Level : "+ snapshot.child('Data').value.toString()+" °C", style: TextStyle(
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

                                          color: Colors.blueGrey,
                                        ),
                                        child: FirebaseAnimatedList
                                          (query: ref, itemBuilder: (context, snapshot, animation, index)
                                        {
                                          return ListTile(
                                            title: Text("Humidity Level : "+ snapshot.child('Data').value.toString()+" °C", style: TextStyle(
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

                                          color: Colors.teal,
                                        ),
                                        child: FirebaseAnimatedList
                                          (query: reference2, itemBuilder: (context, snapshot, animation, index)
                                        {
                                          return ListTile(
                                            title: Text("Smoke Precentage: "+ snapshot.child('Data').value.toString()+" ppm", style: TextStyle(
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
                                          (query: reference3, itemBuilder: (context, snapshot, animation, index)
                                        {
                                          return ListTile(
                                            title: Text("LPG Precentage : "+ snapshot.child('Data').value.toString()+" ppm", style: TextStyle(
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
  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
