import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task_model.dart';

class TaskService {
  final SupabaseClient _client = Supabase.instance.client;

  // READ: Mengambil semua tugas
  Future<List<TaskModel>> getTasks() async {
    final response = await _client
        .from('tasks')
        .select()
        .order('created_at', ascending: false);

    return response.map((task) => TaskModel.fromJson(task)).toList();
  }

  // CREATE: Menambahkan tugas
  Future<void> addTask(TaskModel task) async {
    await _client.from('tasks').insert(task.toJson());
  }

  // UPDATE: Mengubah tugas
  Future<void> updateTask(TaskModel task) async {
    if (task.id == null) {
      throw Exception('ID tugas tidak ditemukan');
    }

    await _client.from('tasks').update(task.toJson()).eq('id', task.id!);
  }

  // DELETE: Menghapus tugas
  Future<void> deleteTask(int id) async {
    await _client.from('tasks').delete().eq('id', id);
  }
}
