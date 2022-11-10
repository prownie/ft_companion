import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class projectsList extends StatelessWidget {
  projectsList(this.coaData, this.projectsData, this.profileData, {super.key}) {
    projectsData.sort((a, b) {
      return b['updated_at'].compareTo(a['updated_at']) as int;
    });
    var actualCursus = profileData['cursus_users'].length - 1;
    projectsData.where((m) {
      return m['cursus_ids'] =
          profileData['cursus_users'][actualCursus]['cursus_id'] as bool;
    });
  }

  dynamic coaData;
  dynamic projectsData;
  dynamic profileData;
  dynamic projectsSortedByUpdate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5, right: 20),
      child: Container(
        height: projectsData.isNotEmpty ? 200 : 70,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: coaData != null ? Color(coaData['color']) : Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: projectsData.isNotEmpty
                ? projectsData.map<Widget>((project) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          project['project']['name'],
                          style: TextStyle(
                              color: project['validated?'] == true
                                  ? Colors.green
                                  : project['validated?'] == false
                                      ? Colors.red
                                      : Colors.grey),
                        ),
                        dense: true,
                        trailing: project['validated?'] == true
                            ? Icon(Icons.check, color: Colors.green)
                            : project['validated?'] == false
                                ? Icon(Icons.close, color: Colors.red)
                                : Icon(Icons.timer_sharp, color: Colors.grey),
                        subtitle: project['validated?'] == true
                            ? Text(project['final_mark'].toString() + '/100',
                                style: TextStyle(color: Colors.green))
                            : SizedBox.shrink(),
                      ),
                    );
                  }).toList()
                : [
                    Card(
                      child: ListTile(
                        title: Text(
                          'This user isn\'t register for any projects',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        dense: true,
                      ),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
