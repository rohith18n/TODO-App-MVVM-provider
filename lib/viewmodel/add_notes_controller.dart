// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:towner_final_round/data/firestore.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class AddScreenController extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode subtitleFocusNode = FocusNode();
  int selectedIndex = 0;
  late BuildContext homeContext;

  void setImageIndex(int newIndex) {
    selectedIndex = newIndex;
    notifyListeners();
  }

  void addTask(BuildContext context) async {
    bool isSuccess = await FirestoreDatasource().addNote(
      subtitleController.text,
      titleController.text,
      selectedIndex,
    );

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Task added successfully',
          isError: false,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Failed to add task',
          isError: true,
        ),
      );
    }
  }

  Future<void> deleteNote(String noteId, BuildContext context) async {
    bool isSuccess = await FirestoreDatasource().deleteNote(noteId);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Task deleted successfully',
          isError: false,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Failed to delete task',
          isError: true,
        ),
      );
    }
  }

  Future<void> markTaskAsDone(
      BuildContext context, String uuid, bool isDone) async {
    bool isSuccess = await FirestoreDatasource().isDone(uuid, isDone);

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Checkbox updated',
          isError: false,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Failed to update checkbox',
          isError: true,
        ),
      );
    }
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  String? validateSubtitle(String value) {
    if (value.isEmpty) {
      return 'Please enter a subtitle';
    }
    return null;
  }
}
