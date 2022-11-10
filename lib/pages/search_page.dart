import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? _searchTimer;
  List<dynamic> _profilesFound = [];
  String _value = '';

  @override
  void initState() {
    apiController.instance.getToken();
  }

  void initData(List<dynamic> profilesFound) {
    _profilesFound != null ? _profilesFound!.clear() : "";
    List<dynamic> tmp = [];
    try {
      late ImageProvider profilePicture;
      for (dynamic profile in profilesFound) {
        profilePicture = profile['image']['versions']['medium'] != null
            ? Image.network(
                profile['image']['versions']['medium'],
              ).image
            : AssetImage('assets/profile-placeholder.jpg');
        tmp.add({'login': profile['login'], 'profilePicture': profilePicture});
      }
    } catch (e) {
      print('exception captured, but np');
    }

    setState(() {
      _profilesFound = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/duneWallpaper.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            oNeonSearchBar(
              margin: EdgeInsets.symmetric(vertical: 25),
              hint: 'Search for a stud',
              borderWidth: 2,
              backgroundColor: Colors.grey.shade700,
              borderColor: Colors.black,
              spreadColor: Colors.grey.shade500,
              onSearchChanged: (value) {
                if (_searchTimer != null) {
                  _searchTimer!.cancel();
                  _value = value!;
                }
                if (value!.isNotEmpty)
                  _searchTimer = Timer(Duration(milliseconds: 500), () async {
                    initData(await apiController.instance
                        .searchProfilesAutoCompletion(value!));
                  });
                else {
                  setState(() {
                    _profilesFound = [];
                  });
                }
              },
              onSearchTap: () async {
                var profile = await apiController.instance.searchUser(_value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => profilePage(profile),
                  ),
                );
              },
            ),
            _profilesFound.length > 0
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _profilesFound.map<Widget>((profileAutoC) {
                          return InkWell(
                            onTap: () async {
                              var profile = await apiController.instance
                                  .searchUser(profileAutoC['login']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          profilePage(profile)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      profileAutoC['login'],
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          profileAutoC['profilePicture'],
                                      radius: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
