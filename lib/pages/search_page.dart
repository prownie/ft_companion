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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: oAppBar(
        context: context,
        heading: 'Swifty_companion',
      ),
      body: Container(
        child: Column(
          children: [
            // oNeonContainer(
            //     child: Image.asset('assets/logo42Square.png',
            //         width: 80, height: 80),
            //     borderWidth: 2,
            //     borderRadius: BorderRadius.circular(20),
            //     borderColor: Colors.purple),
            oNeonSearchBar(
              hint: 'Search for a stud',
              borderWidth: 2,
              borderColor: Colors.purple,
              onSearchChanged: (value) {
                if (_searchTimer != null) {
                  _searchTimer!.cancel();
                  _value = value!;
                }
                _searchTimer = Timer(Duration(milliseconds: 500), () async {
                  _profilesFound = await apiController.instance
                      .searchProfilesAutoCompletion(value!);
                });
              },
              onSearchTap: () async {
                var profile = await apiController.instance.searchUser(_value);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profilePage(profile)));
              },
            ),

            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
