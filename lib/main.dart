import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denuanime/features/anime/data/datasource/anime_api_datasource.dart';
import 'package:denuanime/features/anime/data/datasource/anime_firebase_datasource.dart';
import 'package:denuanime/features/anime/data/repositories/anime_repo_impl.dart';
import 'package:denuanime/features/anime/domain/cubits/favorite_cubit.dart';
import 'package:denuanime/features/anime/domain/repositories/anime_repo.dart';
import 'package:denuanime/features/auth/data/datasource/auth_firbase_datasource.dart';
import 'package:denuanime/features/auth/data/repositories/auth_firebase_repo_impl.dart';
import 'package:denuanime/features/auth/domain/cubits/auth_cubit.dart';
import 'package:denuanime/features/auth/domain/repositories/auth_repo.dart';
import 'package:denuanime/features/auth/presentation/views/auth_gate.dart';
import 'package:denuanime/features/character/data/datasource/character_api_datasource.dart';
import 'package:denuanime/features/character/data/repositories/character_api_repo_impl.dart';
import 'package:denuanime/features/character/domain/repositories/character_repo.dart';
import 'package:denuanime/features/people/data/datasource/people_api_datasource.dart';
import 'package:denuanime/features/people/data/repositories/people_api_repo_impl.dart';
import 'package:denuanime/features/anime/domain/cubits/anime_cubit.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/domain/cubits/people_cubit.dart';
import 'package:denuanime/firebase_options.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:denuanime/utils/core/api_client.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
  late final AnimeFirebaseDatasource animeFirebaseDatasource =
      AnimeFirebaseDatasource(
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
      );
  late final AnimeRepo animeRepo = AnimeRepoImpl(
    animeApiDatasource,
    animeFirebaseDatasource,
  );
  //* -------------------------

  //* ------ Character API
  late final CharacterApiDatasource characterApiDatasource =
      CharacterApiDatasource(dio);
  late final CharacterRepo characterRepo = CharacterApiRepoImpl(
    characterApiDatasource,
  );

  //* -------- Auth Firebase
  late final AuthFirebaseDatasource authFirebaseDatasource =
      AuthFirebaseDatasource(FirebaseAuth.instance);
  late final AuthRepo authRepo = AuthFirebaseRepoImpl(authFirebaseDatasource);

  //* -------------------------
  @override
  Widget build(BuildContext context) {
    //provides repositories so i can use the same instance when i need
    //a new instance of my cubits (blocproviders in inner screens)
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PeopleRepo>(create: (context) => peopleRepo),
        RepositoryProvider<AnimeRepo>(create: (context) => animeRepo),
        RepositoryProvider<CharacterRepo>(create: (context) => characterRepo),
        RepositoryProvider<AuthRepo>(create: (context) => authRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          //* People Cubit
          BlocProvider(
            create: (context) => PeopleCubit(peopleRepo: peopleRepo),
          ),
          //* Anime Cubit
          BlocProvider(create: (context) => AnimeCubit(animeRepo: animeRepo)),
          //* Auth Cubit
          BlocProvider(create: (context) => AuthCubit(authRepo: authRepo)),
          //* Favorite Cubit
          BlocProvider(
            create: (context) => FavoriteCubit(animeRepo: animeRepo),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: darkMode,
          home: const AuthGate(),
        ),
      ),
    );
  }
}
