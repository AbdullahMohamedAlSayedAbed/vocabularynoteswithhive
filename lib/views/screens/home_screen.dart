import 'package:flutter/material.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';
import 'package:vocabularynoteswithhive/views/widgets/add_word_dialog.dart';
import 'package:vocabularynoteswithhive/views/widgets/color_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManger.white,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddWordDialog(),
          );
        },
        child: const Icon(Icons.add,color: ColorManger.black,size: 40,),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Column(
        children: [ColorWidget(activeColorCode: 0XFFC70039)],
      ),
    );
  }
}
