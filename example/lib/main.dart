import 'package:example/fake_chart_series.dart';
import 'package:fl_animated_linechart/chart/chart_line.dart';
import 'package:fl_animated_linechart/chart/chart_point.dart';
import 'package:fl_animated_linechart/common/dates.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'fl_animated_chart demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with FakeChartSeries {
  int chartIndex = 0;

  @override
  Widget build(BuildContext context) {
    String? title = widget.title ?? '';
    Map<DateTime, double> line1 = createLine2();
    Map<DateTime, double> line2 = createLine2_2();
    Map<DateTime, double> line3 = yAxisUpperMaxMarkerLine();
    Map<DateTime, double> line4 = yAxisUpperMinMarkerLine();
    Map<DateTime, double> line5 = yAxisLowerMinMarkerLine();
    Map<DateTime, double> line6 = yAxisLowerMaxMarkerLine();
    Map<DateTime, double> line7 = createLine2_3();

    LineChart chart;

    if (chartIndex == 0) {
      chart = LineChart.fromDateTimeMaps([
        line1,
        line2,
      ], [
        Colors.green,
        Colors.blue,
      ], [
        'C',
        'C',
      ], tapTextFontWeight: FontWeight.w400);

      // chart = LineChart([
      //   ChartLine([
      //     ChartPoint(1, 1),
      //     ChartPoint(2, 2),
      //     ChartPoint(3, 3),
      //     ChartPoint(4, 4),
      //     ChartPoint(5, 5),
      //     ChartPoint(6, 6),
      //     ChartPoint(7, 7),
      //     ChartPoint(8, 8),
      //   ], Colors.red, "单位")
      // ], Dates(null, null));
    } else if (chartIndex == 1) {
      chart = LineChart.fromDateTimeMaps(
          [createLineAlmostSaveValues()], [Colors.green], ['C'],
          tapTextFontWeight: FontWeight.w400);
    } else {
      chart = LineChart.fromDateTimeMaps([
        line7,
        line3,
        line4,
        line5,
        line6,
      ], [
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.yellow,
        Colors.red,
      ], [
        'C',
        'C',
        'C',
        'C',
        'C',
      ], tapTextFontWeight: FontWeight.w400);
      chart.lines[1].isMarkerLine = true;
      chart.lines[2].isMarkerLine = true;
      chart.lines[3].isMarkerLine = true;
      chart.lines[4].isMarkerLine = true;
    }
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      textStyle: TextStyle(fontSize: 13),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(3))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextButton(
                      style: flatButtonStyle,
                      child: Text(
                        'LineChart',
                        style: TextStyle(
                            color: chartIndex == 0
                                ? Colors.black
                                : Colors.black12),
                      ),
                      onPressed: () {
                        setState(() {
                          chartIndex = 0;
                        });
                      },
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      child: Text('LineChart2',
                          style: TextStyle(
                              color: chartIndex == 1
                                  ? Colors.black
                                  : Colors.black12)),
                      onPressed: () {
                        setState(() {
                          chartIndex = 1;
                        });
                      },
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      child: Text('AreaChart',
                          style: TextStyle(
                              color: chartIndex == 2
                                  ? Colors.black
                                  : Colors.black12)),
                      onPressed: () {
                        setState(() {
                          chartIndex = 2;
                        });
                      },
                    ),
                    TextButton(
                      style: flatButtonStyle,
                      child: Text('MarkerLines',
                          style: TextStyle(
                              color: chartIndex == 3
                                  ? Colors.black
                                  : Colors.black12)),
                      onPressed: () {
                        setState(() {
                          chartIndex = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedLineChart(
                  chart,
                  key: UniqueKey(),
                  showMinutesInTooltip: true,
                  gridColor: Colors.black54,
                  textStyle: TextStyle(fontSize: 30, color: Colors.red),
                  toolTipColor: Colors.white,
                  fillMarkerLines: true,
                  useLineColorsInTooltip: true,
                  legends: chartIndex == 3
                      ? [
                          Legend(
                            title: 'Critical',
                            color: Colors.red,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Legend(
                            title: 'Warning',
                            color: Colors.yellow,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Legend(
                            title: 'Warning',
                            color: Colors.yellow,
                            icon: Icon(
                              Icons.report_problem_rounded,
                              size: 17,
                              color: Colors.yellow,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Legend(
                            title: 'Critical',
                            color: Colors.red,
                            showLeadingLine: true,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ]
                      : [],
                  showMarkerLines: true,
                  verticalMarkerColor: Colors.red,
                  verticalMarker: [
                    DateTime.parse('2012-02-27 13:08:00'),
                    DateTime.parse('2012-02-27 13:16:00')
                  ],
                  verticalMarkerIcon: [
                    Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                  ],
                  xAxisLabelOffset: 45,
                  iconBackgroundColor: Colors.white,
                  legendsRightLandscapeMode: false,
                  yAxisLabelOffset: 40,
                ), //Unique key to force animations
              )),
              SizedBox(width: 200, height: 50, child: Text('')),
            ]),
      ),
    );
  }
}
