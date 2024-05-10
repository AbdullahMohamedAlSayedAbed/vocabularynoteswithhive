import 'package:hive/hive.dart';

part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel {
  @HiveField(0)
  final int indexAtDatabase;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final bool isArabic;
  @HiveField(3)
  final int colorCode;
  @HiveField(4)
  final List<String> arabicSimilarWords;
  @HiveField(5)
  final List<String> englishSimilarWords;
  @HiveField(6)
  final List<String> arabicExamples;
  @HiveField(7)
  final List<String> englishExamples;

  const WordModel(
      {required this.indexAtDatabase,
      required this.text,
      required this.isArabic,
      required this.colorCode,
      this.arabicSimilarWords = const [],
      this.englishSimilarWords = const [],
      this.arabicExamples = const [],
      this.englishExamples = const []});

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords =
        _initializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWords);
  }

  WordModel deleteSimilarWord(
      int indexAtSimilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords =
        _initializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWords.removeAt(indexAtSimilarWord);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWords);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExample = _initializeNewExamples(isArabicExample);
    newExample.add(example);
    return _getWordAfterCheckExample(isArabicExample, newExample);
  }

  WordModel deleteExample(int indexAtExample, bool isArabicExample) {
    List<String> newExample = _initializeNewExamples(isArabicExample);
    newExample.removeAt(indexAtExample);
    return _getWordAfterCheckExample(isArabicExample, newExample);
  }

  WordModel _getWordAfterCheckExample(
      bool isArabicExample, List<String> newExample) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExamples: isArabicExample ? newExample : arabicExamples,
      englishExamples: !isArabicExample ? newExample : englishExamples,
    );
  }

  List<String> _initializeNewSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  List<String> _initializeNewExamples(bool isArabicExamples) {
    if (isArabicExamples) {
      return List.from(arabicExamples);
    } else {
      return List.from(englishExamples);
    }
  }

  WordModel _getWordAfterCheckSimilarWords(
      bool isArabicSimilarWord, List<String> newSimilarWords) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: arabicExamples,
    );
  }

  WordModel decrementIndexAtDatabase() {
    return WordModel(
      indexAtDatabase: indexAtDatabase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishExamples: englishExamples,
      englishSimilarWords: englishSimilarWords,
    );
  }
}
