import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabularynoteswithhive/controllers/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:vocabularynoteswithhive/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';
import 'package:vocabularynoteswithhive/views/widgets/arabic_or_english_widget.dart';
import 'package:vocabularynoteswithhive/views/widgets/color_widget.dart';
import 'package:vocabularynoteswithhive/views/widgets/custom_form.dart';
import 'package:vocabularynoteswithhive/views/widgets/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubit, WriteDataState>(
        listener: (context, state) {
          if (state is WriteDataSuccess) {
            Navigator.pop(context);
          }
          if (state is WriteDataFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(_getSnackBar(state.message));
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            padding: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            color: Color(WriteDataCubit.get(context).colorCode),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ArabicOrEnglish(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    arabicIsSelected: WriteDataCubit.get(context).isArabic,
                  ),
                  const SizedBox(height: 10),
                  ColorWidget(
                      activeColorCode: WriteDataCubit.get(context).colorCode),
                  const SizedBox(height: 10),
                  CustomForm(label: "New Word", formKey: formKey),
                  const SizedBox(height: 12),
                  DoneButton(
                    colorCode: WriteDataCubit.get(context).colorCode,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        WriteDataCubit.get(context).addWord();
                        ReadDataCubit.get(context).getWords();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SnackBar _getSnackBar(String message) => SnackBar(
      backgroundColor: ColorManger.red,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: ColorManger.white),
        ),
      ));
}
