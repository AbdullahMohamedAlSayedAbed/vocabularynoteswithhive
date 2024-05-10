import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:vocabularynoteswithhive/constants/hive_constants.dart';
import 'package:vocabularynoteswithhive/models/word_model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  WriteDataCubit() : super(WriteDataInitial());
  static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box box = Hive.box(HiveConstants.wordsBox);
  String text = "";
  bool isArabic = true;
  int colorCode = 0xff4A47A3;
  void updateText(String text) {
    this.text = text;
    emit(WriteDataInitial());
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
      emit(WriteDataInitial());
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataInitial());
  }

  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words.add(WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode));
      box.put(HiveConstants.wordsList, words);
    }, "We have problems we add word, please try again");
  }

  void deleteWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words.removeAt(indexAtDatabase);
      for (var i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDatabase();
      }
      box.put(HiveConstants.wordsList, words);
    }, "we have problems when we delete word, please try again");
  }

  void addSimilarWord(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    }, "We have problems we add similar word, please try again");
  }

  void addExample(int indexAtDatabase) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].addExample(text, isArabic);
      box.put(HiveConstants.wordsList, words);
    }, "We have problems we add example, please try again");
  }

  void deleteSimilarWord(
      int indexAtDatabase, int indexAtSimilarWord, bool isArabicSimilarWord) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] = words[indexAtDatabase]
          .deleteSimilarWord(indexAtSimilarWord, isArabicSimilarWord);
      box.put(HiveConstants.wordsList, words);
    }, "We have problems we delete similar word, please try again");
  }

  void deleteExample(
      int indexAtDatabase, int indexAtExample, bool isArabicExample) {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDataBase();
      words[indexAtDatabase] =
          words[indexAtDatabase].deleteExample(indexAtExample, isArabicExample);
      box.put(HiveConstants.wordsList, words);
    }, "We have problems we delete similar word, please try again");
  }

  void _tryAndCatchBlock(VoidCallback methodToExecute, String message) {
    emit(WriteDataLoading());
    try {
      methodToExecute.call();
      emit(WriteDataSuccess());
    } catch (e) {
      emit(WriteDataFailure(message: message));
    }
  }

  List<WordModel> _getWordsFromDataBase() =>
      List.from(box.get(HiveConstants.wordsList, defaultValue: []))
          .cast<WordModel>();
}
