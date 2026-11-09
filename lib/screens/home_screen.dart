
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/quote_card.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color accentGold = Color(0xFFE5AD54);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().tasks;

    final total = tasks.length;
    final todo = tasks.where((t) => t.status == 'To Do').length;
    final progress = tasks.where((t) => t.status == 'In Progress').length;
    final completed = tasks.where((t) => t.status == 'Completed').length;

    final percentage = total == 0 ? 0 : (completed / total * 100).round();
    final recentTasks = tasks.take(3).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 650;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Header
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good evening,',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Student! 👋',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFDCE9E1),
                        child: Icon(
                          Icons.person,
                          color: primaryGreen,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Welcome Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your productivity matters!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Stay focused.\nGet things done.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: accentGold,
                              size: 17,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Manage your daily tasks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Overview
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 15),

                  GridView.count(
                    crossAxisCount: wide ? 4 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: wide ? 1.5 : 1.45,
                    children: [
                      _buildOverviewCard(
                        'Total Tasks',
                        total,
                        Icons.assignment_outlined,
                        primaryGreen,
                      ),
                      _buildOverviewCard(
                        'In Progress',
                        progress,
                        Icons.timelapse,
                        const Color(0xFFD69A36),
                      ),
                      _buildOverviewCard(
                        'Completed',
                        completed,
                        Icons.check_circle_outline,
                        const Color(0xFF4D9971),
                      ),
                      _buildOverviewCard(
                        'Pending',
                        todo,
                        Icons.pending_actions,
                        const Color(0xFFCE765B),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Daily Motivation
                  const QuoteCard(),

                  const SizedBox(height: 28),

                  // Progress
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Task completion',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '$percentage%',
                              style: const TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: total == 0 ? 0 : completed / total,
                            minHeight: 10,
                            backgroundColor: const Color(0xFFEAECE8),
                            color: primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$completed of $total tasks completed.',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Recent Tasks
                  const Text(
                    'Recent Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (recentTasks.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          'No tasks available yet.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...recentTasks.map((task) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.task_alt,
                              color: primaryGreen,
                              size: 25,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${task.category} • ${task.date}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              task.status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: task.status == 'Completed'
                                    ? Colors.green
                                    : task.status == 'In Progress'
                                        ? Colors.orange
                                        : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildOverviewCard(
  String title,
  int value,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 25),
        const SizedBox(height: 10),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
