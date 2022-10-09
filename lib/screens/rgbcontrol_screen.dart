import 'package:agrogenicprl/screens/airventilation_screen.dart';
import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:agrogenicprl/screens/rgbsec_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RGBControllscreen extends StatefulWidget {
  const RGBControllscreen({Key? key}) : super(key: key);

  @override
  State<RGBControllscreen> createState() => _RGBControllscreenState();
}

class _RGBControllscreenState extends State<RGBControllscreen> with SingleTickerProviderStateMixin{
  bool darkMode = false;
  bool useSides = false;

  late Animation<Color?> animation;
  late AnimationController controller;

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('RGBEffectiveness/Height');


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
  final streamChart = FirebaseFirestore.instance.collection('RGBEffectiveness').snapshots(includeMetadataChanges: true);


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
                          "RGB Effectiveness",

                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                            minRadius: 16,
                            backgroundImage: AssetImage("assets/plantheightm.png"))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(

                        child: Container(
                            height: MediaQuery.of(context).size.height,
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
                                              "Automated Light service ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Image(
                                                image: AssetImage('assets/plantheightm.png'),
                                                fit: BoxFit.fill,
                                                height: 250,
                                                width: 230,
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
                                                      builder: (context) =>  lighteffeciency()
                                                  ),);
                                              },
                                              child: const Text('Expand View -->', style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          useSides
                                              ? Text(
                                            'RGB Bulb ON',
                                            style: darkMode
                                                ? TextStyle(color: Colors.white,fontSize: 18)
                                                : TextStyle(color: Colors.black,fontSize: 18),
                                          )
                                              : Text(
                                            'RGB Bulb OFF',
                                            style: darkMode
                                                ? TextStyle(color: Colors.white,fontSize: 18)
                                                : TextStyle(color: Colors.black,fontSize: 18),
                                          ),
                                          Switch(
                                            value: this.useSides,
                                            onChanged: (value) {
                                              setState(() {
                                                useSides = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                Expanded(child:
                                Column(

                                    children: <Widget>[
                                      SizedBox(

                                        height: 400, // fixed heigh
                                        child:  ListView(
                                          scrollDirection: Axis.vertical,
                                       padding: const EdgeInsets.all(2),
                                    children:
                                    [

                                      StreamBuilder(
                                          stream: streamChart,
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot) {
                                            if(snapshot.hasError){
                                              return const Text('Wrong data review');
                                            }
                                            if(snapshot.connectionState == ConnectionState.waiting)
                                            {
                                              return const Text("Loading...");
                                            }
                                            if(snapshot.data == null)
                                            {
                                              return const Text("Empty");
                                            }

                                            List listChart = snapshot.data!.docs.map((e) {
                                              return{
                                                'domain':e.data()['Days'],
                                                'measure':e.data()['value'],
                                              };
                                            }).toList();

                                            return AspectRatio(
                                              aspectRatio: 6 / 3,
                                              child: SfLinearGauge(
                                                //Add a new range.
                                                ranges: [
                                                  LinearGaugeRange(endValue:100),
                                                ],
                                                //Add a new bar pointer.
                                                barPointers: [
                                                  LinearBarPointer(value: 60),
                                                ],
                                                //Add a new shape pointer.
                                                markerPointers: [
                                                  LinearShapePointer(value: 88),
                                                ],
                                              ),
                                            );
                                          }
                                      )
                                    ],

                              ),
                                ),],),)
                                  ],
                              ),
                            )
                        )
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
