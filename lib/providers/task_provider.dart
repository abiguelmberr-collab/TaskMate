import 'package:flutter/foundation.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<TaskModel> _tasks = [];

  bool _isLoading = false;
  String? _error;

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  bool get isLoading => _isLoading;
  String? get error => _error;

  TaskProvider() {
    loadTasks();
  }

  // READ: Mengambil data dari Supabase
  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tasks = await _repository.getTasks();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // CREATE: Menambahkan tugas
  Future<void> addTask(TaskModel task) async {
    try {
      _error = null;
      await _repository.addTask(task);
      await loadTasks();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // UPDATE: Mengubah tugas
  Future<void> updateTask(int index, TaskModel task) async {
    if (index < 0 || index >= _tasks.length) return;

    try {
      _error = null;

      final existingTask = _tasks[index];

      final updatedTask = TaskModel(
        id: existingTask.id,
        title: task.title,
        category: task.category,
        priority: task.priority,
        status: task.status,
        date: task.date,
      );

      await _repository.updateTask(updatedTask);

      _tasks[index] = updatedTask;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // DELETE: Menghapus tugas
  Future<void> deleteTask(int index) async {
    if (index < 0 || index >= _tasks.length) return;

    try {
      _error = null;

      final task = _tasks[index];

      if (task.id == null) {
        throw Exception('ID tugas tidak ditemukan');
      }

      await _repository.deleteTask(task.id!);

      _tasks.removeAt(index);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
