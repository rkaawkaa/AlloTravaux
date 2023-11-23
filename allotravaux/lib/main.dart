
import 'package:allotravaux/views/all_conversations_view.dart';
import 'package:allotravaux/views/favorite_view.dart';
import 'package:allotravaux/views/project_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/projects/project_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProjectBloc>(
          create: (BuildContext context) => ProjectBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProjectsView(),
        '/conv': (context) => const AllConversationsView(),
        '/fav': (context) => const FavoriteView(),
      },
    );
  }
}
