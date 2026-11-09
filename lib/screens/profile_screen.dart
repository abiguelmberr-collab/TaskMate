
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color accentGold = Color(0xFFE5AD54);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    final totalTasks = tasks.length;
    final completedTasks =
        tasks.where((task) => task.status == 'Completed').length;
    final pendingTasks =
        tasks.where((task) => task.status == 'To Do').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'TaskMate Student Account',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: accentGold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'STUDENT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Task Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _profileInfoRow(
                      Icons.assignment_outlined,
                      'Total Tasks',
                      '$totalTasks',
                    ),
                    const Divider(height: 25),
                    _profileInfoRow(
                      Icons.check_circle_outline,
                      'Completed Tasks',
                      '$completedTasks',
                    ),
                    const Divider(height: 25),
                    _profileInfoRow(
                      Icons.pending_actions,
                      'Pending Tasks',
                      '$pendingTasks',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'About Application',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.task_alt,
                          color: primaryGreen,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'TaskMate',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'TaskMate is a student task management '
                      'application designed to help students '
                      'organize, track, and manage their daily tasks.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  'Made with Flutter',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: primaryGreen, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryGreen,
          ),
        ),
      ],
    );
  }
}
