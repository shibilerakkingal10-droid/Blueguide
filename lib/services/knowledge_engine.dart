import 'dart:convert';
import 'package:flutter/services.dart';

class KnowledgeEngine {
  late Map<String, dynamic> knowledgeBase;

  Future<void> loadKnowledge() async {
    final data = await rootBundle.loadString(
      'assets/data/fishing_knowledge.json',
    );
    knowledgeBase = json.decode(data);
  }

  String getAnswer(String question) {
    question = question.toLowerCase();

    for (var item in knowledgeBase.values) {
      for (var keyword in item['keywords']) {
        if (question.contains(keyword)) {
          return item['answer'];
        }
      }
    }
    return "I don’t have information on that yet. Please try another question.";
  }
}
