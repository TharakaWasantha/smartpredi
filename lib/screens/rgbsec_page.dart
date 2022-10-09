import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class lighteffeciency extends StatefulWidget {
  const lighteffeciency({Key? key}) : super(key: key);

  @override
  State<lighteffeciency> createState() => _lighteffeciencyState();
}

class _lighteffeciencyState extends State<lighteffeciency> with SingleTickerProviderStateMixin{

  bool darkMode = false;
  bool useSides = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Dashboard()),
            );
          }),
          title: const Text('Light Effective phase'),
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
                ListTile(
                  title: Text('Basil plant 4 month history'),
                  tileColor: Colors.green[200],
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          'Height',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 5 / 2,
                              child: DChartBar(
                                data: [
                                  {
                                    'id': 'Bar 1',
                                    'data': [
                                      {'domain': 'MAY', 'measure': 2},
                                      {'domain': 'JUNE', 'measure': 4},
                                      {'domain': 'JULY', 'measure': 7},
                                      {'domain': 'AUGUST', 'measure': 9},
                                    ],
                                  },
                                  {
                                    'id': 'Bar 2',
                                    'data': [
                                      {'domain': 'MAY', 'measure': 3},
                                      {'domain': 'JUNE', 'measure': 7},
                                      {'domain': 'JULY', 'measure': 12},
                                      {'domain': 'AUGUST', 'measure': 18},
                                    ],
                                  },
                                ],
                                minimumPaddingBetweenLabel: 1,
                                domainLabelPaddingToAxisLine: 16,
                                axisLineTick: 2,
                                axisLinePointTick: 2,
                                axisLinePointWidth: 10,
                                axisLineColor: Colors.green,
                                measureLabelPaddingToAxisLine: 16,
                                barColor: (barData, index, id) => id == 'Bar 1'
                                    ? Colors.green.shade300
                                    : id == 'Bar 2'
                                    ? Colors.green.shade600
                                    : Colors.green.shade900,
                                barValue: (barData, index) =>
                                '${barData['measure']}',
                                showBarValue: true,
                                barValueFontSize: 12,
                                barValuePosition: BarValuePosition.outside,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),



                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: 30.0,
                    animationDuration: 2500,
                    percent: 0.8,
                    center: Text("Growing with RGB Light"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: 21.0,
                    animationDuration: 2500,
                    percent: 0.8,
                    center: Text("Growing without RGB Light"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.green.shade300,
                  ),
                ),
              ],
            ),
          ),



        )
    );
  }
}
