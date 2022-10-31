import 'package:flutter/material.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:neon_widgets/neon_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: oAppBar(
        context: context,
        heading: 'Ft_companion',
      ),
      body: Container(
        child: Column(
          children: [
            Spacer(flex: 1),
            oNeonContainer(
                child: Image.asset('assets/logo42Square.png',
                    width: 80, height: 80),
                borderWidth: 2,
                borderRadius: BorderRadius.circular(20),
                borderColor: Colors.purple),
            Spacer(flex: 1),
            oNeonSearchBar(
              hint: 'Search for a stud',
              borderWidth: 2,
              borderColor: Colors.purple,
              onSearchChanged: (value) {
                print('searchChanged:' + value!);
              },
              onSearchTap: () {
                print('onTap');
              },
            ),
            Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
