import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/res/colors.dart';
import 'package:towner_final_round/viewmodel/add_notes_controller.dart';
import 'package:towner_final_round/widgets/add_formfield.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddScreenController(),
      child: const AddScreenContent(),
    );
  }
}

class AddScreenContent extends StatelessWidget {
  const AddScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddScreenController>(context);
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: controller.titleController,
                focusNode: controller.titleFocusNode,
                hintText: 'Title',
                isTitle: true,
                validator: (value) => controller.validateTitle(value!),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: controller.subtitleController,
                focusNode: controller.subtitleFocusNode,
                hintText: 'Subtitle',
                isSubtitle: true,
                validator: (value) => controller.validateSubtitle(value!),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.setImageIndex(index);
                      },
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
              ),
              const SizedBox(height: 20),
              Row(
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
                        controller.addTask(context);
                      }
                    },
                    child: const Text('Add Task',
                        style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(170, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
