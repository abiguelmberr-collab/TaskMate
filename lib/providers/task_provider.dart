
import 'package:flutter/foundation.dart';
import '../models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [
    const TaskModel(
      title: 'Mobile Programming',
      category: 'College Assignment',
      priority: 'High',
      status: 'In Progress',
      date: '12 November 2026',
    ),
    const TaskModel(
      title: 'Database Project',
      category: 'Project',
      priority: 'Medium',
      status: 'To Do',
      date: '15 November 2026',
    ),
    const TaskModel(
      title: 'UI/UX Presentation',
      category: 'Presentation',
      priority: 'Low',
      status: 'Completed',
      date: '18 November 2026',
    ),
    const TaskModel(
      title: 'Software Engineering',
      category: 'College Assignment',
      priority: 'High',
      status: 'To Do',
      date: '20 November 2026',
    ),
    const TaskModel(
      title: 'Web Development',
      category: 'Project',
      priority: 'Medium',
      status: 'In Progress',
      date: '22 November 2026',
    ),
  ];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  void addTask(TaskModel task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  void updateTask(int index, TaskModel task) {
    if (index < 0 || index >= _tasks.length) return;

    _tasks[index] = task;
    notifyListeners();
  }

  void deleteTask(int index) {
    if (index < 0 || index >= _tasks.length) return;

    _tasks.removeAt(index);
    notifyListeners();
  }
}

