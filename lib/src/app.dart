import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_taking_app/src/config/routes/app_routes.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_bloc.dart';

import 'features/notes/presentation/bloc/notes/notes_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc(),
        ),
        BlocProvider(
          create: (context) => CategorieBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
