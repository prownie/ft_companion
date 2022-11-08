import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyWidget extends StatelessWidget {
  MyWidget(this.profilePicture, this.coaData, this.profileData, {super.key}) {
    actualCursus = profileData['cursus_users'].length - 1;
    xpPercentage = profileData['cursus_users'][actualCursus]['level'] -
        profileData['cursus_users'][actualCursus]['level'].truncate();
  }
  late int actualCursus;
  late double xpPercentage;
  late ImageProvider profilePicture;
  late dynamic coaData;
  late dynamic profileData;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: EdgeInsets.only(left: 10, top: 20),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: drawXp(xpPercentage * 100,
                  coaData != null ? Color(coaData['color']) : Colors.white),
            ),
            CircleAvatar(
              backgroundImage: profilePicture,
              radius: 65,
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, top: 20),
        child: Container(
          child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Level'),
                      Text(profileData['cursus_users'][actualCursus]['level']
                          .toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wallets'),
                      Text(profileData['wallet'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Evaluation Points'),
                      Text(profileData['correction_point'].toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Location'),
                      profileData['location'] != null
                          ? Text(profileData['location'].toString())
                          : Text('Not connected'),
                    ],
                  ),
                  coaData != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text('Coa'),
                                  Container(
                                      child: SvgPicture.network(
                                    coaData['image_url'],
                                    color: Color(coaData['color']),
                                    width: 30.0,
                                    height: 30.0,
                                  )),
                                ],
                              ),
                            ),
                            Text(coaData['name']),
                          ],
                        )
                      : SizedBox.shrink(),
                ]),
          ),
        ),
      ),
    ]);
  }
}
