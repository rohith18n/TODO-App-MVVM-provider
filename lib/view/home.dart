import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:towner_final_round/res/colors.dart';
import 'package:towner_final_round/view/add_note_screen.dart';
import 'package:towner_final_round/viewmodel/home_controller.dart';
import 'package:towner_final_round/widgets/custom_alert_dialogue.dart';
import 'package:towner_final_round/widgets/stream_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreenContent();
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Consumer<HomeScreenProvider>(
            builder: (context, provider, _) => Visibility(
              visible: provider.show,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddScreen(),
                  ));
                },
                backgroundColor: customGreen,
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    title: 'Sign Out',
                    content: 'Are you sure you want to sign out?',
                    confirm: 'Sign Out',
                    cancel: 'Cancel',
                    onConfirm: () {
                      provider.signOut(context);
                      Navigator.of(context).pop();
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              provider.setShow(true);
            }
            if (notification.direction == ScrollDirection.reverse) {
              provider.setShow(false);
            }
            return true;
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: provider.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Tasks To Do',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const StreamNote(false),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const StreamNote(true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
