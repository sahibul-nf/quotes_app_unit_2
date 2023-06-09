import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes_app_unit_2/models/quote_api_model.dart';
import 'package:quotes_app_unit_2/repositories/quotes_repository.dart';

class QuoteController {
  final QuotesRepository _repo = QuotesRepository();

  Future<List<QuoteApi>> getRandomQuotes() async {
    // panggill fungsi di repository
    final data = await _repo.getRandomQuotes();

    // return data/model
    return data;
  }
}

final getRandomQuotesProvider = FutureProvider<List<QuoteApi>>((ref) async {
  // panggil class Controller
  final controller = QuoteController();

  // return data dari fungsi
  return controller.getRandomQuotes();
});
