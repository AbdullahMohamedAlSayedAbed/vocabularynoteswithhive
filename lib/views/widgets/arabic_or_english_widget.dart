import 'package:flutter/material.dart';
import 'package:vocabularynoteswithhive/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';

class ArabicOrEnglish extends StatelessWidget {
  const ArabicOrEnglish(
      {super.key, required this.colorCode, required this.arabicIsSelected});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getCircleDesign(true, context),
        const SizedBox(
          width: 5,
        ),
        _getCircleDesign(false, context),
      ],
    );
  }

  GestureDetector _getCircleDesign(bool buildIsArabic, BuildContext context) {
    return GestureDetector(
      onTap: () {
        WriteDataCubit.get(context).updateIsArabic(buildIsArabic);
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: buildIsArabic == arabicIsSelected
            ? ColorManger.white
            : ColorManger.transparent,
        child: Text(
          buildIsArabic ? "ar" : "en",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: !(buildIsArabic == arabicIsSelected)
                ? ColorManger.white
                : Color(colorCode),
          ),
        ),
      ),
    );
  }
}
