import 'package:denuanime/features/auth/presentation/common/background_glow.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeDrawer extends StatelessWidget {
  final int selected;
  final String name;
  final String email;
  final void Function(int) onSelect;
  final void Function() onSignOut;

  const HomeDrawer({
    super.key,
    required this.selected,
    required this.name,
    required this.email,
    required this.onSelect,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            top: -70,
            right: -50,
            child: BackgroundGlow(color: primaryGlow, size: 170),
          ),
          const Positioned(
            bottom: -50,
            left: -80,
            child: BackgroundGlow(color: primarySoft, size: 170),
          ),
          const Positioned(
            bottom: 140,
            left: 0,
            child: BackgroundGlow(color: primaryDeep, size: 70),
          ),
          Column(
            children: [
              //* HEADER
              DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primary, width: 2),
                        image: const DecorationImage(
                          image: AssetImage('assets/splash_logo_only.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DenuAnime",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Anime companion app",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //* NAVIGATION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
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
              ),

              const Spacer(),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withValues(alpha: .05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primary, width: 3),
                      ),
                      child: Center(
                        child: Text(
                          "N",
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(color: primary),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),
                    //*names
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(fontSize: 14),
                          ),
                          Text(
                            email,
                            overflow: TextOverflow.ellipsis,

                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    //* signout button
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/ic_signout.svg',
                        colorFilter: const ColorFilter.mode(
                          white,
                          BlendMode.srcIn,
                        ),
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
