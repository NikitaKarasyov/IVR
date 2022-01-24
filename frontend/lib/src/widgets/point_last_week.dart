import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PointWeek extends StatelessWidget {
  final List<double> weekPoints;

  const PointWeek(this.weekPoints, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text("Points this week",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            CustomBarChart(weekPoints),
          ],
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  final List<double> weekData;
  const _BarChart(this.weekData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        // maxY: 20,
        gridData:
            FlGridData(drawHorizontalLine: false, drawVerticalLine: false),
      ),
      swapAnimationCurve: Curves.easeIn,
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 0,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Color(0xff7589a2),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: weekData.isNotEmpty ? weekData[0] : 0,
                width: 25,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[1] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[2] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[3] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[4] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[5] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
                width: 25,
                y: weekData.isNotEmpty ? weekData[6] : 0,
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class CustomBarChart extends StatefulWidget {
  final List<double> weekData;
  const CustomBarChart(this.weekData, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomBarChartState(weekData);
}

class CustomBarChartState extends State<CustomBarChart> {
  final List<double> weekData;

  CustomBarChartState(this.weekData);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.7,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.grey.shade200,
          child: Container(
              margin: const EdgeInsets.only(top: 18),
              child: _BarChart(weekData)),
        ));
  }
}
