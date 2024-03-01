// carbon history

import 'dart:math';

import 'package:eco_panda/page_template.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ECarbonHistory extends StatefulWidget {
  const ECarbonHistory({Key? key}) : super(key: key);

  @override
  State<ECarbonHistory> createState() => _ECarbonHistoryState();
}

class _ECarbonHistoryState extends State<ECarbonHistory> {
  // Replace these with your actual data
  final double _currentMonthFootprint = 2.5; // Current month's carbon footprint
  final List<FlSpot> _historicalDataSpots = [
    FlSpot(0, 2.8),
    FlSpot(1, 3.2),
    FlSpot(2, 2.9),
  ];
  final List<double> _pastFootprints = [2.8, 3.2, 2.9, 3.1, 3.0]; // Past carbon footprints

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Current Month's Carbon Footprint
            Card(
              margin: const EdgeInsets.all(12.0),
              child: ListTile(
                title: const Text('Current Month\'s Carbon Footprint'),
                subtitle: Text('$_currentMonthFootprint tons'),
              ),
            ),

            // Historical Data of Monthly Carbon Footprint
            Card(
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Historical Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 200.0,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: _historicalDataSpots.length.toDouble() - 1,
                          minY: _historicalDataSpots.map((e) => e.y).reduce(min),
                          maxY: _historicalDataSpots.map((e) => e.y).reduce(max),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _historicalDataSpots,
                              isCurved: true,
                              color: Colors.black,
                              barWidth: 4,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),

            // List of Past Carbon Footprints
            Card(
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Past Carbon Footprints', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ..._pastFootprints.map((footprint) => ListTile(
                      title: Text('$footprint tons'),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}