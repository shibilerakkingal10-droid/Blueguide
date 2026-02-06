import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/knowledge_entry.dart';

/// Service for loading and searching knowledge base
class KnowledgeService {
  static final KnowledgeService _instance = KnowledgeService._internal();
  factory KnowledgeService() => _instance;
  KnowledgeService._internal();

  List<KnowledgeEntry> _knowledgeBase = [];
  bool _isLoaded = false;

  /// Load data.json once at app startup
  Future<void> loadKnowledge() async {
    if (_isLoaded) return;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> chatbotData = jsonData['chatbot_data'] as List;

      _knowledgeBase =
          chatbotData.map((json) => KnowledgeEntry.fromJson(json)).toList();
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading knowledge base: $e');
      _knowledgeBase = [];
    }
  }

  /// Search knowledge base and return top 3 matching entries
  /// 
  /// Scoring logic:
  /// - Each keyword match: +10 points
  /// - Partial match in question: +5 points
  /// - Category match: +3 points
  List<KnowledgeEntry> search(String userQuery) {
    if (!_isLoaded || userQuery.trim().isEmpty) {
      return [];
    }

    // Normalize query to lowercase
    final normalizedQuery = userQuery.toLowerCase().trim();
    final queryWords = normalizedQuery.split(' ');

    // Score each entry using a typed class for better performance
    final List<_ScoredEntry> scoredEntries = [];

    for (final entry in _knowledgeBase) {
      int score = 0;

      // Check keyword matches
      for (final keyword in entry.keywords) {
        final normalizedKeyword = keyword.toLowerCase();
        
        // Exact match
        if (normalizedQuery.contains(normalizedKeyword)) {
          score += 10;
        }
        
        // Check for partial word matches
        for (final word in queryWords) {
          if (normalizedKeyword.contains(word) && word.length > 2) {
            score += 5;
          }
        }
      }

      // Check question match
      final normalizedQuestion = entry.question.toLowerCase();
      for (final word in queryWords) {
        if (normalizedQuestion.contains(word) && word.length > 2) {
          score += 5;
        }
      }

      // Check category match
      final normalizedCategory = entry.category.toLowerCase();
      for (final word in queryWords) {
        if (normalizedCategory.contains(word) && word.length > 2) {
          score += 3;
        }
      }

      if (score > 0) {
        scoredEntries.add(_ScoredEntry(entry, score));
      }
    }

    // Sort by score (highest first)
    scoredEntries.sort((a, b) => b.score.compareTo(a.score));

    // Return top 3 entries
    final topEntries = scoredEntries
        .take(3)
        .map((item) => item.entry)
        .toList();

    return topEntries;
  }

  /// Get total number of entries in knowledge base
  int get entryCount => _knowledgeBase.length;

  /// Check if knowledge base is loaded
  bool get isLoaded => _isLoaded;
}

/// Internal class for storing scored entries
class _ScoredEntry {
  final KnowledgeEntry entry;
  final int score;

  _ScoredEntry(this.entry, this.score);
}
