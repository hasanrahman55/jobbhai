extension SentenceSplitter on String {
  List<String> sentenceToList() {
    return split('.')
        .where((sentence) => sentence.trim().isNotEmpty)
        .map((sentence) => sentence.trim())
        .toList();
  }
}
