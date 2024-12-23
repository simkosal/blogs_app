import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Stream<List<String>> fetchHtmlContent() {
    return client
        .from('blogs') // Replace with your table name
        .stream(
            primaryKey: ['id']) // Ensure you have a primary key (e.g., 'id')
        .map((response) {
      if (response.isEmpty) {
        // Handle error
        return [];
      } else {
        // Extract the descriptions from the response
        final List<dynamic> data = response;
        return data.map((item) => item['description'] as String).toList();
      }
    });
  }
}
