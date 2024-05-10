import 'package:flutter/material.dart';
import 'package:vocabularynoteswithhive/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabularynoteswithhive/views/styles/color_manager.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> _colorCodes = const [
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
    0xFF8FBC8F,
    0xFFFA8072,
    0XFF4D4C7D,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _getItemDesign(index, context);
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 7,
              ),
          itemCount: _colorCodes.length),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        WriteDataCubit.get(context).updateColorCode(_colorCodes[index]);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: activeColorCode == _colorCodes[index]
              ? Border.all(color: ColorManger.white, width: 2)
              : null,
          color: Color(_colorCodes[index]),
        ),
        child: activeColorCode == _colorCodes[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: ColorManger.white,
                  size: 30,
                ),
              )
            : null,
      ),
    );
  }
}
