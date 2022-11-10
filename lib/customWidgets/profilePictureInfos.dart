import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class profilePictureInfos extends StatelessWidget {
  profilePictureInfos(this.coaData, this.profileData, {super.key}) {
    actualCursus = profileData['cursus_users'].length - 1;
    xpPercentage = profileData['cursus_users'][actualCursus]['level'] -
        profileData['cursus_users'][actualCursus]['level'].truncate();
    profilePicture = profileData['image']['versions']['medium'] != null
        ? Image.network(profileData['image']['versions']['medium']).image
        : AssetImage('assets/profile-placeholder.jpg');
  }
  late int actualCursus;
  late double xpPercentage;
  late ImageProvider profilePicture;
  late dynamic coaData;
  late dynamic profileData;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color:
                      coaData != null ? Color(coaData['color']) : Colors.white),
              borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.coffee_rounded,
                            color: coaData != null
                                ? Color(coaData['color'])
                                : Colors.white),
                        SizedBox(width: 5),
                        Text('Level',
                            style: TextStyle(fontSize: 17, color: Colors.white))
                      ]),
                      Text(
                          profileData['cursus_users'][actualCursus]['level']
                              .toString(),
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.attach_money_rounded,
                            color: coaData != null
                                ? Color(coaData['color'])
                                : Colors.white),
                        SizedBox(width: 5),
                        Text('Wallets',
                            style: TextStyle(fontSize: 17, color: Colors.white))
                      ]),
                      Text(profileData['wallet'].toString(),
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.currency_exchange_rounded,
                            color: coaData != null
                                ? Color(coaData['color'])
                                : Colors.white),
                        SizedBox(width: 5),
                        Text('Evaluation Points',
                            style: TextStyle(fontSize: 17, color: Colors.white))
                      ]),
                      Text(profileData['correction_point'].toString(),
                          style: TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.house_rounded,
                            color: coaData != null
                                ? Color(coaData['color'])
                                : Colors.white),
                        SizedBox(width: 5),
                        Text('Location',
                            style: TextStyle(fontSize: 17, color: Colors.white))
                      ]),
                      profileData['location'] != null
                          ? Text(profileData['location'].toString(),
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white))
                          : Text('Not connected',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                    ],
                  ),
                  coaData != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                      child: SvgPicture.network(
                                    coaData['image_url'],
                                    color:
                                        Color(coaData['color'] ?? Colors.white),
                                    width: 24.0,
                                    height: 24.0,
                                  )),
                                  SizedBox(width: 5),
                                  Text('Coa',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white)),
                                ],
                              ),
                            ),
                            Text(coaData['name'],
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white)),
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
