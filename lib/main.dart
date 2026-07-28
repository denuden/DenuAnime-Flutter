import 'package:denuanime/features/auth/presentation/views/landing_view.dart';
import 'package:denuanime/features/people/data/datasource/people_api_datasource.dart';
import 'package:denuanime/features/people/data/repositories/people_api_repo_impl.dart';
import 'package:denuanime/features/people/domain/repositories/people_repo.dart';
import 'package:denuanime/features/people/presentation/cubits/people_cubit.dart';
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

  //* ------ People Datasource
  late final PeopleApiDatasource peopleApiDatasource = PeopleApiDatasource(dio);
  late final PeopleRepo peopleRepo = PeopleApiRepoImpl(peopleApiDatasource);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //* People Cubit
        BlocProvider(create: (context) => PeopleCubit(peopleRepo: peopleRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkMode,
        home: const LandingView(),
      ),
    );
  }
}
