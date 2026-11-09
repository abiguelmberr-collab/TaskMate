
class QuoteModel {
  final int id;
  final String quote;
  final String author;

  const QuoteModel({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] ?? 0,
      quote: json['quote'] ?? '',
      author: json['author'] ?? 'Unknown',
    );
  }
}
