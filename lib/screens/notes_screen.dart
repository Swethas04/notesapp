import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/notes_provider.dart';
import '../model/note.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  static const List<Color> _noteColors = <Color>[
    Color(0xFFFFF4E1),
    Color(0xFFE3F6F5),
    Color(0xFFFFE3E3),
    Color(0xFFF0E7FF),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesControllerProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/bg3.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.45)),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text(
                  'My Notes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: notesState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (notes) {
                  if (notes.isEmpty) {
                    return _FreshEmptyState(
                      onAdd: () => _openEditor(context, ref),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final Note note = notes[index];
                      return _FreshNoteCard(
                        note: note,
                        color: _noteColors[index % _noteColors.length],
                        onEdit: () => _openEditor(context, ref, note: note),
                        onDelete:
                            () => ref
                                .read(notesControllerProvider.notifier)
                                .deleteNote(note.id),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _openEditor(context, ref),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref, {
    Note? note,
  }) async {
    final TextEditingController titleController = TextEditingController(
      text: note?.title,
    );
    final TextEditingController contentController = TextEditingController(
      text: note?.content,
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => Container(
            padding: EdgeInsets.fromLTRB(
              20,
              24,
              20,
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    hintText: 'Write something...',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {
                      if (titleController.text.trim().isEmpty) {
                        return;
                      }

                      if (note == null) {
                        ref
                            .read(notesControllerProvider.notifier)
                            .addNote(
                              titleController.text.trim(),
                              contentController.text.trim(),
                            );
                      } else {
                        ref
                            .read(notesControllerProvider.notifier)
                            .updateNote(
                              note.id,
                              titleController.text.trim(),
                              contentController.text.trim(),
                            );
                      }

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _FreshNoteCard extends StatelessWidget {
  const _FreshNoteCard({
    required this.note,
    required this.color,
    required this.onEdit,
    required this.onDelete,
  });

  final Note note;
  final Color color;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            note.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(note.content, maxLines: 4, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FreshEmptyState extends StatelessWidget {
  const _FreshEmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.notes_rounded, size: 72, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          const Text(
            'No notes yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          const Text('Tap + to start writing'),
        ],
      ),
    );
  }
}
