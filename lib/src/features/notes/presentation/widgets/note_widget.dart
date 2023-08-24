import 'package:flutter/material.dart';
import 'package:notes_taking_app/src/features/notes/domain/entities/note.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_sizes.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColores.secondaryColor,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
      ),
      width: 100,
      child: ListTile(
        title: Text(note.note),
        subtitle: Text(note.dateTime.toString().substring(0, 16)),
      ),
    );
  }
}
