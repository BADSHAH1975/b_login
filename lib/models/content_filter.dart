class InappropriateContentFilter {
  final List<String> bannedWords;
  final List<RegExp> bannedPatterns;

  InappropriateContentFilter(this.bannedWords, this.bannedPatterns);

  String filterComment(String comment) {
    String sanitizedComment = comment;

    bannedWords.forEach((word) {
      sanitizedComment = sanitizedComment.replaceAll(RegExp(r'\b' + word + r'\b', caseSensitive: false), '***');
    });

    bannedPatterns.forEach((pattern) {
      sanitizedComment = sanitizedComment.replaceAll(pattern, '***');
    });

    return sanitizedComment;
  }
}
