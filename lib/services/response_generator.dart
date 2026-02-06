import '../models/knowledge_entry.dart';

/// Service for generating natural language responses from search results
class ResponseGenerator {
  /// Generate a formatted response from search results
  /// 
  /// FUTURE ENHANCEMENT:
  /// This is where a local LLM (TinyLlama, llama.cpp) can be integrated
  /// to generate more natural and contextual responses.
  /// 
  /// Integration steps for future LLM:
  /// 1. Load the LLM model (e.g., TinyLlama) using flutter_llama or similar
  /// 2. Create a prompt template combining user question + retrieved answers
  /// 3. Pass the prompt to the LLM for generation
  /// 4. Return the LLM-generated response
  /// 
  /// Example prompt template:
  /// ```
  /// Context information:
  /// ${results.map((e) => e.answer).join('\n')}
  /// 
  /// User question: $userQuestion
  /// 
  /// Please provide a helpful answer based on the context above.
  /// ```
  static String generate(String userQuestion, List<KnowledgeEntry> results) {
    // If no results found
    if (results.isEmpty) {
      return "Sorry, I do not have information about that yet. Please try asking about fish production, fishing regulations, or marine life.";
    }

    // If single result - return it directly
    if (results.length == 1) {
      return results[0].answer;
    }

    // Multiple results - format with bullets
    final StringBuffer response = StringBuffer();
    response.writeln("Here is what I found:\n");

    for (int i = 0; i < results.length; i++) {
      response.writeln("• ${results[i].answer}");
      
      // Add spacing between items (except last one)
      if (i < results.length - 1) {
        response.writeln();
      }
    }

    return response.toString().trim();
  }

  /// Generate a response with category headers (alternative formatting)
  static String generateWithCategories(
      String userQuestion, List<KnowledgeEntry> results) {
    if (results.isEmpty) {
      return "Sorry, I do not have information about that yet.";
    }

    if (results.length == 1) {
      return results[0].answer;
    }

    final StringBuffer response = StringBuffer();
    response.writeln("Here is what I found:\n");

    for (int i = 0; i < results.length; i++) {
      response.writeln("${results[i].category}:");
      response.writeln("${results[i].answer}");
      
      if (i < results.length - 1) {
        response.writeln();
      }
    }

    return response.toString().trim();
  }
}
