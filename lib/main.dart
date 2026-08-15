import 'package:denuanime/features/anime/data/datasource/anime_api_datasource.dart';
import 'package:denuanime/features/anime/data/repositories/anime_api_repo_impl.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/features/auth/presentation/views/landing_view.dart';
import 'package:denuanime/features/character/data/datasource/character_api_datasource.dart';
import 'package:denuanime/features/character/data/repositories/character_api_repo_impl.dart';
import 'package:denuanime/features/character/domain/cubits/character_cubit.dart';
import 'package:denuanime/features/character/domain/repositories/character_repo.dart';
import 'package:denuanime/features/people/data/datasource/people_api_datasource.dart';
import 'package:denuanime/features/people/data/repositories/people_api_repo_impl.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  //* ==== DIO for API calls
  final Dio dio = ApiClient.create();

  //* ------ People API
  late final PeopleApiDatasource peopleApiDatasource = PeopleApiDatasource(dio);
  late final PeopleRepo peopleRepo = PeopleApiRepoImpl(peopleApiDatasource);
  //* -------------------------

  //* ------ Anime API
  late final AnimeApiDatasource animeApiDatasource = AnimeApiDatasource(dio);
  late final AnimeRepo animeRepo = AnimeApiRepoImpl(animeApiDatasource);
  //* -------------------------

  //* ------ Character API
  late final CharacterApiDatasource characterApiDatasource =
      CharacterApiDatasource(dio);
  late final CharacterRepo characterRepo = CharacterApiRepoImpl(
    characterApiDatasource,
  );
  //* -------------------------
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PeopleRepo>(create: (context) => peopleRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          //* People Cubit
          BlocProvider(
            create: (context) => PeopleCubit(peopleRepo: peopleRepo),
          ),
          //* Anime Cubit
          BlocProvider(create: (context) => AnimeCubit(animeRepo: animeRepo)),
          //* Character Cubit
          BlocProvider(
            create: (context) => CharacterCubit(
              characterRepo: characterRepo,
              peopleRepo: peopleRepo,
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: darkMode,
          home: const LandingView(),
        ),
      ),
    );
  }
}
