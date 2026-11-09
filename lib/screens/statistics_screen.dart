
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color accentGold = Color(0xFFE5AD54);

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    final total = tasks.length;
    final todo = tasks.where((t) => t.status == 'To Do').length;
    final progress =
        tasks.where((t) => t.status == 'In Progress').length;
    final completed =
        tasks.where((t) => t.status == 'Completed').length;

    final percentage =
        total == 0 ? 0 : (completed / total * 100).round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Task Overview',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Track your productivity and progress.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Tasks',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$total',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: total == 0 ? 0 : completed / total,
                        minHeight: 10,
                        backgroundColor: Colors.white24,
                        color: accentGold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$percentage% tasks completed',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Task Status',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 15),
              _buildStatCard(
                'To Do',
                todo,
                Icons.pending_actions,
                Colors.blue,
              ),
              _buildStatCard(
                'In Progress',
                progress,
                Icons.autorenew,
                Colors.orange,
              ),
              _buildStatCard(
                'Completed',
                completed,
                Icons.check_circle_outline,
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
