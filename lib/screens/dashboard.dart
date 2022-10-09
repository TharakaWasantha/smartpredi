import 'package:agrogenicprl/screens/air.dart';
import 'package:agrogenicprl/screens/airventilation_screen.dart';
import 'package:agrogenicprl/screens/chart.dart';
import 'package:agrogenicprl/screens/fertilizermng_screen.dart';
import 'package:agrogenicprl/screens/fertinew.dart';
import 'package:agrogenicprl/screens/pestrepelent_screen.dart';
import 'package:agrogenicprl/screens/rgbcontrol_screen.dart';
import 'package:agrogenicprl/screens/rgbefeect_screen.dart';


import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();

}
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .90,
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),

          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 62,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 72,
                        child: Image.asset('assets/logo.png'),                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Agrogenic',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,letterSpacing: 3,fontSize:38,),

                          ),
                          Text("Let's Start ! ",style: TextStyle(color: Colors.purple, letterSpacing: 2, fontWeight: FontWeight.w400,fontSize:14),)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 45,),

                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  PestRepellent()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/pestc.jpg'),
                            fit: BoxFit.fill,
                            height: 20,
                          ),
                        ),
                      ),

                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  air()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/temp.jpg'),
                            fit: BoxFit.fill,
                            height: 20,
                          ),

                        ),
                      ),


                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  fertilive()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/fertilizer.png'),
                            fit: BoxFit.fill,
                            height: 20,
                          ),

                        ),
                      ),

                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // builder: (context) =>  lighteffeciency()
                                  builder: (context) =>  RGBControllscreen()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/light.png'),
                            fit: BoxFit.fill,
                            height: 20,
                          ),

                        ),
                      ),

                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  chart()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/profile.png'),
                            fit: BoxFit.fill,
                            height: 20,
                          ),

                        ),
                      ),

                      Card(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Airventilation()
                              ),);
                          },
                          child: Image(
                            image: AssetImage('assets/guide.png',),
                            fit: BoxFit.fill,
                            height: 20,
                          ),

                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  }