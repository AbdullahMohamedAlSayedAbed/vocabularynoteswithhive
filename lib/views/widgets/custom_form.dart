import 'package:flutter/material.dart';
import 'package:vocabularynoteswithhive/controllers/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:vocabularynoteswithhive/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.label, required this.formKey});
  final String label;
  final GlobalKey<FormState> formKey;
  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: TextFormField(
          autofocus: true,
          controller: controller,
          onChanged: (value) => WriteDataCubit.get(context).updateText(value),
          validator: (value) {
            return _validator(value, WriteDataCubit.get(context).isArabic);
          },
          minLines: 1,
          maxLines: 3,
          style: const TextStyle(color: ColorManger.white),
          cursorColor: ColorManger.white,
          decoration: _getInputDecoration(),
        ));
  }

  String? _validator(String? value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    for (var i = 0; i < value.length; i++) {
      CharType charType = _getCharType(value.codeUnitAt(i));
      if (charType == CharType.notValid) {
        return "Char number ${i + 1} Not valid";
      } else if (charType == CharType.arabic && isArabic == false) {
        return "Char number ${i + 1} is Not english character";
      }else if (charType == CharType.english && isArabic == true) {
        return "Char number ${i + 1} is Not arabic character";
      }
    }
    return null;
  }

  CharType _getCharType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 90) ||
        (asciiCode >= 97 && asciiCode <= 127)) {
      return CharType.english;
    } else if (asciiCode >= 1569 && asciiCode <= 1610) {
      return CharType.arabic;
    } else if (asciiCode == 32) {
      return CharType.space;
    } else {
      return CharType.notValid;
    }
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      label: Text(
        widget.label,
        style: const TextStyle(color: ColorManger.white),
      ),
      enabledBorder: _customOutlineInputBorder(),
      focusedBorder: _customOutlineInputBorder(),
      border: _customOutlineInputBorder(),
      errorBorder: _customOutlineInputBorder(),
      focusedErrorBorder: _customOutlineInputBorder(),
    );
  }

  OutlineInputBorder _customOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: ColorManger.white, width: 2));
  }
}

enum CharType { arabic, english, space, notValid }
