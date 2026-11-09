
class TaskModel {
  final int? id;
  final String title;
  final String category;
  final String priority;
  final String status;
  final String date;

  const TaskModel({
    this.id,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    required this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int?,
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      priority: json['priority'] ?? 'Medium',
      status: json['status'] ?? 'To Do',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'priority': priority,
      'status': status,
      'date': date,
    };
  }
}
