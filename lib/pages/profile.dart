import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ft_companion/customWidgets/customWidgets.dart';
import 'package:ft_companion/customWidgets/customWidgets.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:neon_widgets/neon_widgets.dart';
// import 'dart:math';

class profilePage extends StatefulWidget {
  profilePage(this.profileData, {super.key});
  dynamic profileData;
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  late bool isFound = false;
  late bool isLoading = true;
  dynamic profileData;
  dynamic coaData;

  @override
  void initState() {
    if (widget.profileData['id'] != 0) {
      profileData = widget.profileData;
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
      resizeToAvoidBottomInset: false,
      body: isFound
          ? Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/duneWallpaper.jpg"),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              profileData['usual_full_name'],
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                    profilePictureInfos(coaData, profileData),
                    section(coaData, 'Projects'),
                    projectsList(
                        coaData, profileData['projects_users'], profileData),
                    section(coaData, 'Skills'),
                    skillsDisplay(profileData, coaData),
                  ],
                ),
              ),
            )
          : isLoading
              ? Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/duneWallpaper.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Column(children: [Spacer(), Text('Loading'), Spacer()]),
                      Spacer(),
                    ],
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/duneWallpaper.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Column(children: [
                        Spacer(),
                        Text('User not found',
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Spacer()
                      ]),
                      Spacer(),
                    ],
                  ),
                ),
    );
  }
}
