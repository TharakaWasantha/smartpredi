import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class fertiscrn extends StatefulWidget {
  const fertiscrn({Key? key}) : super(key: key);
  @override
  State<fertiscrn> createState() => _fertiscrnState();
}

class _fertiscrnState extends State<fertiscrn> {
  var datan = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0]; //sample data -N
  var datap = [1.0, 0.2, 0.5, 0.0, 0.0, 0.5, -0.5, -1.0, -0.5, 0.0, 1.0]; //sample data -P
  var datak = [0.3, 0.4, 0.5, 0.5, 0.7, 0.5, -0.5, -1.0, -0.5, 0.0, 0.3]; //sample data -K
  static const String _title = 'Flutter Code Sample';

  //switch
  bool manualMode = false;
  bool autoMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Dashboard()),
          );
        }),
        title: const Text('Fertilizer phase'),
        actions: <Widget>[
          IconButton(icon: Icon(
              FontAwesomeIcons.chartLine), onPressed: () {
          }
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage('assets/fertiscrnmfile.png'),
                  fit: BoxFit.fill,
                  height: 210,
                  width: 250,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    autoMode
                        ? Text(
                      'Water pump control : Auto',
                      style: manualMode
                          ? TextStyle(color: Colors.white,fontSize: 18)
                          : TextStyle(color: Colors.black,fontSize: 18),
                    )
                        : Text(
                      'Water pump control : Manual',
                      style: manualMode
                          ? TextStyle(color: Colors.white,fontSize: 18)
                          : TextStyle(color: Colors.red,fontSize: 18),
                    ),
                    Switch(
                      value: this.autoMode,
                      onChanged: (value) {
                        setState(() {
                          autoMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: versachart("NPK value detected","System run","N : 2.3mg"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: pvaluechart("NPK value detected","System run","P : 0.8mg"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: kvaluechart("NPK value detected","System run","K : 1.2mg"),
              ),
            ],
          ),

        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'logout',
          ),

        ],
      ),
    );

  }


  Material versachart(String title, String priceVal,String subtitle) {
    return Material(
      color:Color(0xffffffff),
      elevation: 14.0,
      borderRadius: BorderRadius.circular(3.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(priceVal, style: TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Sparkline(
                      data: datan,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Material pvaluechart(String title, String priceVal,String subtitle) {
    return Material(
      color:Color(0xffffffff),
      elevation: 14.0,
      borderRadius: BorderRadius.circular(3.0),
      shadowColor: Color(0x8021B308),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Sparkline(
                      data: datap,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material kvaluechart(String title, String priceVal,String subtitle) {
    return Material(
      color:Color(0xffffffff),
      elevation: 14.0,
      borderRadius: BorderRadius.circular(3.0),
      shadowColor: Color(0x8021B308),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Sparkline(
                      data: datak,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

