import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ft_companion/customWidgets/customWidgets.dart';
import 'package:ft_companion/utils/utils.dart';
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
  late bool isLoading = true;
  dynamic profileData;
  late double xpPercentage = 0.0;
  late int level = 0;
  late ImageProvider profilePicture;
  dynamic coaData;
  List<dynamic> projects = [];

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
            coaData['color'] =
                int.parse(coaData['color'].replaceAll('#', 'FF'), radix: 16);
          });
        }
        setState(() {
          isLoading = false;
          isFound = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: oAppBar(context: context, heading: 'Swifty_companion'),
      body: isFound
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                  ),
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
                            painter: drawXp(
                                xpPercentage * 100,
                                coaData != null
                                    ? Color(coaData['color'])
                                    : Colors.white),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Level'),
                                    Text(profileData['cursus_users']
                                            [actualCursus]['level']
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
                                        ? Text(
                                            profileData['location'].toString())
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
                                                  color:
                                                      Color(coaData['color']),
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
                  ]),
                  projectsList(projects)
                ],
              ),
            )
          : isLoading
              ? Container(
                  child: Row(
                    children: [
                      Spacer(),
                      Column(children: [Spacer(), Text('Loading'), Spacer()]),
                      Spacer(),
                    ],
                  ),
                )
              : Container(
                  child: Row(
                    children: [
                      Spacer(),
                      Column(children: [
                        Spacer(),
                        Text('User not found'),
                        Spacer()
                      ]),
                      Spacer(),
                    ],
                  ),
                ),
    );
  }
}
