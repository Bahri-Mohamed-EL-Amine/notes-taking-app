import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_taking_app/src/core/utils/app_colors.dart';
import 'package:notes_taking_app/src/core/utils/app_sizes.dart';
import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_bloc.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_states.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/notes/notes_events.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _controller = TextEditingController();
  String value = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              final Note note = Note(
                note: _controller.text,
                category: value,
                dateTime: DateTime.now(),
              );
              BlocProvider.of<NotesBloc>(context)
                  .add(NotesAddEvent(note: note));
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.appPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColores.secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.folder_open_rounded,
                      color: AppColores.accentColor,
                    ),
                    BlocBuilder<CategorieBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesUpdateState) {
                          List<DropdownMenuItem<String>> items = state
                              .categories
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList();
                          return DropdownButton<String>(
                            underline: Container(),
                            iconSize: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            value: value,
                            items: items,
                            onChanged: (v) {
                              setState(() {
                                value = v ?? 'All';
                              });
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
              Text(
                DateTime.now().toString().substring(0, 16),
                style: const TextStyle(color: Colors.grey),
              ),
              TextField(
                controller: _controller,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start typing',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
