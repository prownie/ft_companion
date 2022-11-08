import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ft_companion/utils/draw_xp.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'dart:math';
import '../utils/utils.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:flutter_svg/flutter_svg.dart';

class profilePage extends StatefulWidget {
  profilePage(this.profileData, {super.key});
  dynamic profileData;
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  late int actualCursus;
  late bool isFound = false;
  dynamic profileData;
  late double xpPercentage = 0.0;
  late int level = 0;
  late ImageProvider profilePicture;
  dynamic coaData;

  @override
  void initState() {
    if (widget.profileData['id'] != 0) {
      profileData = widget.profileData;
      actualCursus = profileData['cursus_users'].length - 1;
      xpPercentage = profileData['cursus_users'][actualCursus]['level'] -
          profileData['cursus_users'][actualCursus]['level'].truncate();
      profilePicture = profileData['image']['versions']['medium'] != null
          ? Image.network(profileData['image']['versions']['medium']).image
          : AssetImage('assets/profile-placeholder.jpg');
      apiController.instance
          .getCoalitionsData(profileData['login'])
          .then((value) {
        if (value != null && value['name'] != null) {
          setState(() {
            coaData = value;
            print(coaData['color']);
            coaData['color'] = coaData['color'].replaceAll('#', '');
            print(coaData['color']);
            print(StringToHex.toColor(coaData['color']));
          });
        }
      });
      setState(() {
        isFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: oAppBar(context: context, heading: 'Swifty_companion'),
      body: isFound
          ? oNeonContainer(
              child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    profileData['usual_full_name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: drawXp(xpPercentage * 100),
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
                      decoration: BoxDecoration(color: Colors.blue),
                      child: oNeonContainer(
                        borderColor:
                            // Color(StringToHex.toColor(coaData['color'])),
                            Colors.blue,
                        height: 130,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Level'),
                                  Text(profileData['cursus_users'][actualCursus]
                                          ['level']
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Wallets'),
                                  Text(profileData['wallet'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Evaluation Points'),
                                  Text(profileData['correction_point']
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Location'),
                                  profileData['location'] != null
                                      ? Text(profileData['location'].toString())
                                      : Text('Not connected'),
                                ],
                              ),
                              coaData != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text('Coa'),
                                              Container(
                                                  child: SvgPicture.network(
                                                coaData['image_url'],
                                                width: 40.0,
                                                height: 40.0,
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
                ])
              ],
            ))
          : oNeonContainer(
              child: Row(
                children: [
                  Spacer(),
                  Column(
                      children: [Spacer(), Text('User not found'), Spacer()]),
                  Spacer(),
                ],
              ),
            ),
    );
  }
}
