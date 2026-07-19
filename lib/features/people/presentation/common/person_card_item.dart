import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class PersonCardItem extends StatelessWidget {
  const PersonCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      elevation: 16,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: white.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //? ===== Anime character
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      "https://cdn.myanimelist.net/images/anime/1295/106551t.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jet Black",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Main Character",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            //? ===== VA
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  //* ==========card
                  Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(color: tertiary),
                      color: glass,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      //*=== details
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "https://cdn.myanimelist.net/images/anime/1295/106551t.jpg",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "JP VA",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: primaryLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  "Matsuoka  Yoshitsugu",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  "Japanese",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //*======= other actors
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("6 voice actors"),
                      SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_right, size: 14),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
