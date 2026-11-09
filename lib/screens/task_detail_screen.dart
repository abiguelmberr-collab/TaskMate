
import 'package:flutter/material.dart';

import '../models/task_model.dart';

const Color primaryGreen = Color(0xFF234B3D);

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5EF),
      appBar: AppBar(
        title: const Text(
          'Task Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryGreen,
          ),
        ),
        backgroundColor: const Color(0xFFF7F5EF),
        foregroundColor: primaryGreen,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.task_alt,
                    size: 42,
                    color: primaryGreen,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  _detailItem(
                    Icons.category_outlined,
                    'Category',
                    task.category,
                  ),
                  _detailItem(
                    Icons.flag_outlined,
                    'Priority',
                    task.priority,
                  ),
                  _detailItem(
                    Icons.pending_actions,
                    'Status',
                    task.status,
                  ),
                  _detailItem(
                    Icons.calendar_today_outlined,
                    'Date',
                    task.date,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
