import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_analytics/screens/home/provider/user_state.dart';
import 'package:sport_analytics/screens/home/widgets/stats_row.dart';
import 'package:sport_analytics/utils/user_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_colors.dart';
import '../../utils/stats_response.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDataSetIndex = -1;
  String? firstName;
  int speed = 0;
  int heartRate = 0;
  int stamina = 0;
  int strength = 0;
  String? userToken;
  bool isDataFetched = false;

  late UserPreferences userPreferences;


  Future<void> getUserToken() async {
    userToken = await UserPreferences.getUserId();
    fetchStats();
  }

  Future<void> fetchStats() async {
    try {
      if (userToken == null) {
        print("User token is null or empty");
        return;
      }
      final response = await http.get(
        Uri.parse('http://10.0.2.2:4000/api/v1/users/stats/'),
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data.toString());
        final statsResponse = StatsResponse.fromJson(data);

        if (!statsResponse.error && statsResponse.list.isNotEmpty) {
          final latestStats = statsResponse.list.first;
          setState(() {
            speed = latestStats.physicals;
            heartRate = latestStats.speed;
            stamina = latestStats.stamina;
            strength = latestStats.strength;
            updateProgress();
          });
        } else {
          print(statsResponse.message); 
        }
      } else {
        print('Failed to fetch stats: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(title: "Speed", color: Colors.red, values: [speed.toDouble(), speed.toDouble(), speed.toDouble()]),
      RawDataSet(title: "HeartRate", color: Colors.blue, values: [stamina.toDouble(), stamina.toDouble(), stamina.toDouble()]),
      RawDataSet(title: "Stamina", color: Colors.green, values: [strength.toDouble(), strength.toDouble(), strength.toDouble()]),
      RawDataSet(title: "Strength", color: Colors.yellow, values: [heartRate.toDouble(), heartRate.toDouble(), heartRate.toDouble()]),
    ];
  }
  List statsArray = [
    {
      "name": "Speed(m/s)",
      "image": "assets/images/Workout1.png",
      "progress": 0.0
    },
    {
      "name": "Heart Rate(BPM)",
      "image": "assets/images/Workout2.png",
      "progress": 0.0
    },
    {
      "name": "Stamina(%)",
      "image": "assets/images/Workout3.png",
      "progress": 0.0
    },
    {
      "name": "Strength(Kg)",
      "image": "assets/images/Workout2.png",
      "progress": 0.0
    },
  ];

  void updateProgress() {
    for (var stats in statsArray) {
      switch (stats['name']) {
        case 'Speed(m/s)':
          stats['progress'] = speed / 100.0;
          break;
        case 'Heart Rate(BPM)':
          stats['progress'] = heartRate / 100.0;
          break;
        case 'Stamina(%)':
          stats['progress'] = stamina / 100.0;
          break;
        case 'Strength(Kg)':
          stats['progress'] = strength / 100.0;
          break;
        default:
          break;
      }
    }
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    userNotifier.fetchUserDetails();
    getUserToken();
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;
      final isSelected = index == selectedDataSetIndex || selectedDataSetIndex == -1;

      return RadarDataSet(
        fillColor: isSelected ? rawDataSet.color.withOpacity(0.2) : rawDataSet.color.withOpacity(0.05),
        borderColor: isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries: rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final userFirstName = Provider.of<UserNotifier>(context).user?.firstName ?? "User";
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: fetchStats,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome Back,",
                            style: TextStyle(
                              color: AppColors.midGrayColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            userFirstName,
                            style: const TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 24,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: media.width * 0.1),
                  const Text("Analysis Charts",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: media.width * 0.05),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    height: media.width * 0.5,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.lightGrayColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: RadarChart(
                      swapAnimationDuration: const Duration(milliseconds: 150),
                      // Optional
                      swapAnimationCurve: Curves.linear,
                      RadarChartData(
                        radarShape: RadarShape.polygon,
                        radarBackgroundColor: Colors.transparent,
                        borderData: FlBorderData(show: false),
                        radarBorderData: const BorderSide(color: Colors.transparent),
                        radarTouchData: RadarTouchData(
                            touchCallback: (FlTouchEvent event, response) {}),
                        dataSets: showingDataSets(),
                        ticksTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Stats",
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: statsArray.length,
                      itemBuilder: (context, index) {
                        var wObj = statsArray[index] as Map? ?? {};
                        return InkWell(
                            onTap: () {}, child: WorkoutRow(wObj: wObj));
                      }),
                  SizedBox(
                    height: media.width * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}
