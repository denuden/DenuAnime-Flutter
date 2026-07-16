import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final int selected;
  final void Function(int) onSelect;

  const HomeDrawer({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () => onSelect(0),
            selected: selected == 0,
            selectedTileColor: primary,
            selectedColor: inversePrimary,
            leading: const Icon(Icons.home_filled),
          ),
          ListTile(
            title: const Text("Favorites"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            onTap: () => onSelect(1),
            selected: selected == 1,
            selectedTileColor: primary,
            selectedColor: inversePrimary,
            leading: const Icon(Icons.favorite),
          ),
          ListTile(
            title: const Text("Recents"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            onTap: () => onSelect(2),
            selected: selected == 2,
            selectedTileColor: primary,
            selectedColor: inversePrimary,
            leading: const Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}
