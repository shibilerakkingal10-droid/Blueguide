import 'package:flutter/material.dart';
import '../services/knowledge_service.dart';
import '../services/response_generator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final KnowledgeService _knowledgeService = KnowledgeService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeKnowledge();
  }

  Future<void> _initializeKnowledge() async {
    await _knowledgeService.loadKnowledge();
    setState(() {
      _isLoading = false;
      _messages.add(ChatMessage(
        text:
            'Hello! I\'m your Blueguide assistant. Ask me about fish production, fishing regulations, or marine life.',
        isUser: false,
      ));
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
    });

    // Scroll to bottom
    _scrollToBottom();

    // Get response from knowledge service
    _generateResponse(text);
  }

  Future<void> _generateResponse(String userMessage) async {
    // Search knowledge base
    final results = _knowledgeService.search(userMessage);

    // Generate response
    final reply = ResponseGenerator.generate(userMessage, results);

    setState(() {
      _messages.add(ChatMessage(text: reply, isUser: false));
    });

    // Scroll to bottom
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fishing Assistant'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  ),
                ),
                const Divider(height: 1.0),
                _buildTextComposer(),
              ],
            ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration(
                hintText: 'Ask me anything about fishing...',
                contentPadding: EdgeInsets.all(16.0),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: const Icon(Icons.assistant, color: Colors.white),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          if (isUser)
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
