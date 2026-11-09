import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskRepository {
  final TaskService _service = TaskService();

  Future<List<TaskModel>> getTasks() {
    return _service.getTasks();
  }

  Future<void> addTask(TaskModel task) {
    return _service.addTask(task);
  }

  Future<void> updateTask(TaskModel task) {
    return _service.updateTask(task);
  }

  Future<void> deleteTask(int id) {
    return _service.deleteTask(id);
  }
}