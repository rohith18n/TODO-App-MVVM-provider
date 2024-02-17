import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/model/notes_model.dart';
import 'package:towner_final_round/res/colors.dart';
import 'package:towner_final_round/viewmodel/edit_notes_controller.dart';
import 'package:towner_final_round/widgets/edit_formfield.dart';

class EditScreen extends StatelessWidget {
  final Note note;

  const EditScreen(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditScreenController(note),
      child: const EditScreenContent(),
    );
  }
}

class EditScreenContent extends StatelessWidget {
  const EditScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EditScreenController>(context);

    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomEditTextField(
                controller: controller.titleController,
                focusNode: controller.titleFocusNode,
                hintText: 'Title',
                validator: (value) => controller.validateTitle(value!),
              ),
              const SizedBox(height: 20),
              CustomEditTextField(
                controller: controller.subtitleController,
                focusNode: controller.subtitleFocusNode,
                hintText: 'Subtitle',
                maxLines: 3,
                validator: (value) => controller.validateSubtitle(value!),
              ),
              const SizedBox(height: 20),
              _buildImageSelection(controller),
              const SizedBox(height: 20),
              _buildButton(controller, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(EditScreenController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: customGreen,
            minimumSize: const Size(170, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.updateNote(
                context,
                controller.note.id,
                controller.titleController.text,
                controller.subtitleController.text,
              );
            }
          },
          child: const Text('Add Task', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(170, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildImageSelection(EditScreenController controller) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.setImageIndex(index),
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: controller.selectedIndex == index
                        ? customGreen
                        : Colors.grey,
                  ),
                ),
                width: 140,
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset('images/$index.png'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
