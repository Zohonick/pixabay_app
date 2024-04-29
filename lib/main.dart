import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pixabay/bloc/pixabay_bloc.dart';
import 'package:pixabay/Repository/pixabay_repository.dart';
import 'package:pixabay/screens/home_screen.dart';
import 'package:pixabay/widgets/loader_widget.dart';

GetIt getIt = GetIt.instance;

void main() {
  getItInitial();
  runApp(const MyApp());
}

void getItInitial() {
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<PixabayRepository>(PixabayRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PixaBay Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade300),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PixaBay'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          PixabayBloc()..add(PixabayInitialEvent()),
      child: BlocBuilder<PixabayBloc, PixabayState>(builder: (context, state) {
        if (state is PixabayLoadedState) {
          return buildHomeScreen(context, title, state);
        } else {
          return buildLoader();
        }
      }),
    );
  }
}
