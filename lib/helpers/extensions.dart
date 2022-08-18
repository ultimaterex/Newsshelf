extension StringExtensions on String {
  String stripHtml() {
    return replaceAll(
        RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), "");
  }

  Map<String, int> getWordFrequency() {
    final splitContent = split(" ");
    final wordFrequency = <String, int>{};
    for (final w in splitContent) {
      wordFrequency[w] = 1 + (wordFrequency[w] ?? 0);
    }
    return wordFrequency;
  }
}
