import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class skillsDisplay extends StatelessWidget {
  skillsDisplay(this.profileData, this.coaData, {super.key}) {
    var actualCursus = profileData['cursus_users'].length - 1;
    skills = profileData['cursus_users'][actualCursus]['skills'];
    skills.sort((a, b) {
      return b['name'].compareTo(a['name']) as int;
    });
    for (Map<String, dynamic> skill in skills) {
      features.add(skill['name']);
      data[0].add(skill['level']);
    }

    print('skills');
    print(skills);
  }

  dynamic profileData;
  dynamic skills;
  dynamic coaData;
  final ticks = [5, 10, 15, 20];
  List<String> features = [];
  List<List<double>> data = [[]];
  bool useSides = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Container(
        height: skills.isNotEmpty ? 200 : 70,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: coaData != null ? Color(coaData['color']) : Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: skills.isNotEmpty
            ? RadarChart(
                ticks: ticks,
                features: features,
                data: data,
                reverseAxis: false,
                graphColors: [
                  coaData != null ? Color(coaData['color']) : Colors.white
                ],
                axisColor: Colors.grey,
                featuresTextStyle: TextStyle(color: Colors.white, fontSize: 10),
              )
            : Card(
                child: ListTile(
                  title: Text(
                    'This user has no skills yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  dense: true,
                ),
              ),
      ),
    );
  }
}
