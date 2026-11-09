
import 'package:flutter/material.dart';

import '../models/task_model.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color accentGold = Color(0xFFE5AD54);

class TaskFormDialog extends StatefulWidget {
  final TaskModel? task;

  const TaskFormDialog({
    super.key,
    this.task,
  });

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String category;
  late String priority;
  late String status;
  DateTime? deadline;

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();

    final task = widget.task;

    title = task?.title ?? '';
    category = task?.category ?? '';
    priority = task?.priority ?? 'Medium';
    status = task?.status ?? 'To Do';
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];

    return months[month - 1];
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        deadline = picked;
      });
    }
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    if (!isEditing && deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a deadline'),
        ),
      );
      return;
    }

    final oldTask = widget.task;

    final result = TaskModel(
      id: oldTask?.id,
      title: title.trim(),
      category: category.trim(),
      priority: priority,
      status: status,
      date: deadline == null
          ? oldTask!.date
          : '${deadline!.day} ${_monthName(deadline!.month)} ${deadline!.year}',
    );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isEditing ? 'Edit Task' : 'Add New Task',
        style: const TextStyle(
          color: primaryGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: title,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Task name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  initialValue: category,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => category = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Category is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: priority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  items: ['High', 'Medium', 'Low']
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => priority = value);
                    }
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: ['To Do', 'In Progress', 'Completed']
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => status = value);
                    }
                  },
                ),
                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    deadline == null
                        ? (isEditing
                            ? 'Keep deadline: ${widget.task!.date}'
                            : 'Choose Deadline')
                        : '${deadline!.day}/${deadline!.month}/${deadline!.year}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            foregroundColor: Colors.white,
          ),
          onPressed: _saveTask,
          child: Text(isEditing ? 'Save Changes' : 'Save Task'),
        ),
      ],
    );
  }
}
