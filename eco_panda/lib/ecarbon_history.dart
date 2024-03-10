import 'dart:math';
import 'package:eco_panda/page_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'floor_model/app_database.dart';
import 'floor_model/app_entity.dart';

class ECarbonHistory extends StatefulWidget {
  const ECarbonHistory({Key? key}) : super(key: key);

  @override
  State<ECarbonHistory> createState() => _ECarbonHistoryState();
}

class _ECarbonHistoryState extends State<ECarbonHistory> {
  double _currentMonthFootprint = 0.0;
  List<FlSpot> _historicalDataSpots = [];
  List<double> _pastFootprints = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final localDb = Provider.of<AppDatabase>(context, listen: false);

    final DateTime now = DateTime.now();
    final String currentYearMonth = "${now.year}-${now.month.toString().padLeft(2, '0')}";

    History? currentMonthData = await localDb.historyDao.retrieveHistoryByYearMonth(currentYearMonth, userId);

    if (currentMonthData == null) {
      currentMonthData = History(
        yearMonth: currentYearMonth,
        historyCarbonFootprint: 0,
        userId: userId,
      );
      await localDb.historyDao.insertHistory(currentMonthData);
    }

    List<History> historyData = await localDb.historyDao.retrieveHistoriesByUid(userId);

    setState(() {
      _currentMonthFootprint = currentMonthData!.historyCarbonFootprint.toDouble();
      _pastFootprints = historyData.map((e) => e.historyCarbonFootprint.toDouble()).toList();
      _historicalDataSpots = historyData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.historyCarbonFootprint.toDouble())).toList();
    });
  }

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
                subtitle: Text('$_currentMonthFootprint pts'),
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
                          maxX: _historicalDataSpots.isEmpty ? 1 : _historicalDataSpots.length.toDouble() - 1,
                          minY: _historicalDataSpots.isEmpty ? 0 : _historicalDataSpots.map((e) => e.y).reduce(min),
                          maxY: _historicalDataSpots.isEmpty ? 1 : _historicalDataSpots.map((e) => e.y).reduce(max),
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