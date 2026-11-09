
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/quote_model.dart';

class QuoteService {
  Future<List<QuoteModel>> getQuotes() async {
    final url = Uri.parse(
      'https://dummyjson.com/quotes?limit=5',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      final List quotes = data['quotes'];

      return quotes
          .map((quote) => QuoteModel.fromJson(quote))
          .toList();
    } else {
      throw Exception(
        'Gagal mengambil data quotes: ${response.statusCode}',
      );
    }
  }
}
