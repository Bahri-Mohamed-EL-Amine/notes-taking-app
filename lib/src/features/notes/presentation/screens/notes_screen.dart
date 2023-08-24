import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_taking_app/src/config/routes/app_routes.dart';
import 'package:notes_taking_app/src/core/utils/app_colors.dart';
import 'package:notes_taking_app/src/core/utils/app_sizes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_bloc.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_events.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_states.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/notes/notes_events.dart';
import 'package:notes_taking_app/src/features/notes/presentation/widgets/note_widget.dart';

import '../../domain/entities/note.dart';
import '../bloc/notes/notes_bloc.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotesBloc>(context).add(NotesFecthAllEvent());
    BlocProvider.of<CategorieBloc>(context).add(CategorieFecthAllEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextField(
              onChanged: (value) {
                BlocProvider.of<NotesBloc>(context)
                    .add(NotesSearchEvent(value: value));
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.textFieldBorderRadius,
                  ),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                ),
                hintText: 'Search notes',
                fillColor: AppColores.secondaryColor,
                filled: true,
              ),
            ),
            const SizedBox(
              height: AppSizes.appPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: BlocBuilder<CategorieBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesInitialState) {
                          return const Text('empty');
                        }
                        if (state is CategoriesUpdateState) {
                          return ListView.builder(
                            itemCount: state.categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<NotesBloc>(context).add(
                                      NotesFilterEvent(
                                          categorie: state.categories[index]));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: AppColores.secondaryColor,
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.cardBorderRadius),
                                    ),
                                    child: Center(
                                      child: Text(state.categories[index]),
                                    )),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    icon: const Icon(
                      Icons.folder_open_rounded,
                      color: AppColores.accentColor,
                    )),
              ],
            ),
            Expanded(
              child:
                  BlocBuilder<NotesBloc, List<Note>>(builder: (context, state) {
                if (state.isEmpty) {
                  return const Center(
                    child: Text('No notes found'),
                  );
                } else {
                  return MasonryGridView.count(
                      crossAxisCount: 2,
                      itemCount: state.length,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        return NoteWidget(note: state[index]);
                      });
                }
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColores.accentColor,
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addNoteRoute);
        },
        child: const Icon(
          Icons.add_rounded,
          color: AppColores.primaryColor,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: 'Unnamed Folder');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'New folder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            AppSizes.textFieldBorderRadius),
                        borderSide: BorderSide.none),
                    hintText: 'Unnamed folder',
                    fillColor: AppColores.secondaryColor,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColores.secondaryColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColores.accentColor)),
                onPressed: () {
                  BlocProvider.of<CategorieBloc>(context)
                      .add(CategorieAddEvent(categorie: controller.text));
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ),
          ],
        );
      },
    );
  }
}
