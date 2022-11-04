import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ft_companion/utils/draw_xp.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'dart:math';
import '../utils/utils.dart';

class profilePage extends StatelessWidget {
  profilePage(this.profileData, {super.key});

  dynamic profileData;

  @override
  Widget build(BuildContext context) {
    var lastCursus = profileData['cursus_users'].length - 1;
    double xpPercentage = profileData['cursus_users'][lastCursus]['level'] -
        profileData['cursus_users'][lastCursus]['level'].truncate();
    print(xpPercentage);
    return Scaffold(
      appBar: oAppBar(context: context, heading: 'Swifty_companion'),
      body: profileData['id'] != null
          ? oNeonContainer(
              child: Row(children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40, top: 40),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            painter: drawXp(xpPercentage * 100),
                          ),
                          CircleAvatar(
                            backgroundImage: Image.network(
                                    profileData['image']['versions']['medium'])
                                .image,
                            radius: 65,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [],
                )
              ]),
            )
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
