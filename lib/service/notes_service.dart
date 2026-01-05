import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/note.dart';

class NotesService {
  final SupabaseClient _client;

  NotesService(this._client);

  Future<List<Note>> fetchNotes(String userId) async {
    final data = await _client
        .from('notes')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    //return (data as List).map((e) => Note.fromJson(e)).toList();
    final List<dynamic> rawList = data as List<dynamic>;

    return rawList
        .map((dynamic e) => Note.fromJson(e as Map<String, dynamic>))
        .toList();

  }

  Future<void> addNote({
    required String userId,
    required String title,
    required String content,
  }) async {
    await _client.from('notes').insert({
      'title': title,
      'content': content,
      'user_id': userId,
    });
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required String content,
  }) async {
    await _client
        .from('notes')
        .update({'title': title, 'content': content})
        .eq('id', id);
  }

  Future<void> deleteNote(String id) async {
    await _client.from('notes').delete().eq('id', id);
  }
}
