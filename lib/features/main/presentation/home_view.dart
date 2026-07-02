import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //? =========== variable
  int _selectedIndex = 0;

  //? ============ functions
  void _onMenuSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });

    //* close drawer
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                "Denu Anime",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListTile(
              title: const Text("Home"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              onTap: () => _onMenuSelection(0),
              selected: _selectedIndex == 0,
              selectedTileColor: primary,
              selectedColor: inversePrimary,
              leading: Icon(Icons.home_filled),
            ),
            ListTile(
              title: const Text("Favorites"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              onTap: () => _onMenuSelection(1),
              selected: _selectedIndex == 1,
              selectedTileColor: primary,
              selectedColor: inversePrimary,
              leading: Icon(Icons.favorite),
            ),
            ListTile(
              title: const Text("Recents"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              onTap: () => _onMenuSelection(2),
              selected: _selectedIndex == 2,
              selectedTileColor: primary,
              selectedColor: inversePrimary,
              leading: Icon(Icons.history),
            ),
          ],
        ),
      ),
    );
  }
}
