import 'package:flutter/material.dart';

class AnimeDetailsView extends StatefulWidget {
  const AnimeDetailsView({super.key});

  @override
  State<AnimeDetailsView> createState() => _AnimeDetailsViewState();
}

class _AnimeDetailsViewState extends State<AnimeDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Anime Details")));
  }
}
