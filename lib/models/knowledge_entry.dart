/// Model class representing a knowledge entry from the JSON data
class KnowledgeEntry {
  final String category;
  final List<String> keywords;
  final String question;
  final String answer;

  KnowledgeEntry({
    required this.category,
    required this.keywords,
    required this.question,
    required this.answer,
  });

  /// Create a KnowledgeEntry from JSON
  factory KnowledgeEntry.fromJson(Map<String, dynamic> json) {
    return KnowledgeEntry(
      category: json['category'] as String,
      keywords: List<String>.from(json['keywords'] as List),
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  /// Convert to JSON (useful for debugging)
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'keywords': keywords,
      'question': question,
      'answer': answer,
    };
  }
}
