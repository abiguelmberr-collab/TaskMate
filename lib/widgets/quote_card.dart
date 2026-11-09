
import 'package:flutter/material.dart';

import '../models/quote_model.dart';
import '../services/quote_service.dart';

const Color quoteGreen = Color(0xFF234B3D);

class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  final QuoteService _service = QuoteService();

  late Future<List<QuoteModel>> _quotesFuture;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  void _loadQuotes() {
    _quotesFuture = _service.getQuotes();
  }

  void _retry() {
    setState(() {
      _loadQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuoteModel>>(
      future: _quotesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildContainer(
            const Center(
              child: CircularProgressIndicator(
                color: quoteGreen,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildContainer(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cloud_off,
                  color: Colors.grey,
                  size: 30,
                ),
                const SizedBox(height: 8),
                const Text('Failed to load quote'),
                TextButton(
                  onPressed: _retry,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        final quotes = snapshot.data ?? [];

        if (quotes.isEmpty) {
          return _buildContainer(
            const Text('No quotes available'),
          );
        }

        final quote = quotes.first;

        return _buildContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.format_quote,
                    color: quoteGreen,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Daily Motivation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: quoteGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '"${quote.quote}"',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '- ${quote.author}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: quoteGreen,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 130),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE9E1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
