import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabularynoteswithhive/constants/hive_constants.dart';
import 'package:vocabularynoteswithhive/controllers/read_data_cubit/cubit/read_data_cubit.dart';
import 'package:vocabularynoteswithhive/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabularynoteswithhive/models/word_model.dart';
import 'package:vocabularynoteswithhive/views/screens/home_screen.dart';
import 'package:vocabularynoteswithhive/views/styles/them_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const VocabularyNotes());
}

class VocabularyNotes extends StatelessWidget {
  const VocabularyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReadDataCubit()),
        BlocProvider(create: (context) => WriteDataCubit()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManger.getAppTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
