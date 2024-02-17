import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/viewmodel/add_notes_controller.dart';
import 'package:towner_final_round/widgets/custom_alert_dialogue.dart';
import 'package:towner_final_round/widgets/task_widgets.dart';
import '../data/firestore.dart';

class StreamNote extends StatelessWidget {
  final bool done;

  const StreamNote(this.done, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreDatasource().stream(done),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SizedBox(
              height: 50,
              child: Center(
                  child: Text(done == false
                      ? "No Tasks To Do"
                      : " No Tasks Completed")));
        }

        final notesList = FirestoreDatasource().getNotes(snapshot);

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            final note = notesList[index];
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd ||
                    direction == DismissDirection.endToStart) {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        confirm: "DELETE",
                        title: "Confirm",
                        content: "Are you sure you want to delete this task?",
                        onConfirm: () => Navigator.of(context).pop(true),
                        onCancel: () => Navigator.of(context).pop(false),
                        cancel: 'CANCEL',
                      );
                    },
                  );
                }
                return true;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd ||
                    direction == DismissDirection.endToStart) {
                  Provider.of<AddScreenController>(context, listen: false)
                      .deleteNote(note.id, context);
                }
              },
              child: TaskWidget(note),
            );
          },
        );
      },
    );
  }
}
