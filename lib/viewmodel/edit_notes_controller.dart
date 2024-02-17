// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:towner_final_round/data/firestore.dart';
import 'package:towner_final_round/model/notes_model.dart';
import 'package:towner_final_round/widgets/snackbar_messenger.dart';

class EditScreenController extends ChangeNotifier {
  late TextEditingController titleController;
  late TextEditingController subtitleController;
  final formKey = GlobalKey<FormState>();
  late FocusNode titleFocusNode;
  late FocusNode subtitleFocusNode;
  late Note note;

  int selectedIndex = 0;

  EditScreenController(this.note) {
    titleController = TextEditingController(text: note.title);
    subtitleController = TextEditingController(text: note.subtitle);
    titleFocusNode = FocusNode();
    subtitleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    titleFocusNode.dispose();
    subtitleFocusNode.dispose();
    super.dispose();
  }

  void setImageIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateNote(BuildContext context, String noteId, String title,
      String subtitle) async {
    bool isSuccess = await FirestoreDatasource().updateNote(
      noteId,
      selectedIndex,
      title,
      subtitle,
    );

    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Note updated successfully',
          isError: false,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          message: 'Failed to update note',
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
