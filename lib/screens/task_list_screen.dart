import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';
import 'task_detail_screen.dart';
import '../widgets/task_form_dialog.dart';

const Color primaryGreen = Color(0xFF234B3D);
const Color accentGold = Color(0xFFE5AD54);

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String selectedFilter = 'All';

  List<TaskModel> get tasks => context.read<TaskProvider>().tasks;

  List<TaskModel> get filteredTasks {
    if (selectedFilter == 'All') {
      return tasks;
    }

    return tasks.where((task) => task.status == selectedFilter).toList();
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.redAccent;
      case 'Medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  Future<void> _showAddTaskDialog() async {
  final newTask = await showDialog<TaskModel>(
    context: context,
    builder: (dialogContext) {
      return const TaskFormDialog();
    },
  );

  if (newTask != null && mounted) {
    context.read<TaskProvider>().addTask(newTask);

    setState(() {
      selectedFilter = 'All';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task added successfully!'),
        backgroundColor: primaryGreen,
      ),
    );
  }
}

  

  Future<void> _showEditTaskDialog(int index) async {
  final oldTask = tasks[index];

  final editedTask = await showDialog<TaskModel>(
    context: context,
    builder: (dialogContext) {
      return TaskFormDialog(task: oldTask);
    },
  );

  if (editedTask != null && mounted) {
    context.read<TaskProvider>().updateTask(index, editedTask);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task updated successfully!'),
        backgroundColor: primaryGreen,
      ),
    );
  }
}

  Future<void> _deleteTask(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Task?'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      context.read<TaskProvider>().deleteTask(index);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task deleted successfully!'),
          backgroundColor: primaryGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TaskProvider>();

    return LayoutBuilder(
      builder: (context, constraints) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Stay organized!',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'My Tasks',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0xFFDCE9E1),
                        child: Icon(Icons.checklist, color: primaryGreen),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Summary
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.assignment_outlined,
                          color: accentGold,
                          size: 35,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Tasks',
                              style: TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '${tasks.length} Tasks',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showAddTaskDialog,
                      icon: const Icon(Icons.add),
                      label: const Text('Add New Task'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Filter Tasks',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Filter
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['All', 'To Do', 'In Progress', 'Completed'].map((
                      filter,
                    ) {
                      return ChoiceChip(
                        label: Text(filter),
                        selected: selectedFilter == filter,
                        selectedColor: const Color(0xFFDCE9E1),
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 25),

                  // Task list heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Task List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryGreen,
                        ),
                      ),
                      Text(
                        '${filteredTasks.length} Tasks',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Task cards
                  if (filteredTasks.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          'No tasks found.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredTasks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(17),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TaskDetailScreen(task: task),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: primaryGreen,
                                        ),
                                      ),
                                    ),

                                    // Label Priority
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getPriorityColor(task.priority)
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        task.priority,
                                        style: TextStyle(
                                          color: getPriorityColor(
                                            task.priority,
                                          ),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    // Menu Edit dan Delete
                                    PopupMenuButton<String>(
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      onSelected: (value) {
                                        final taskIndex = tasks.indexOf(task);

                                        if (taskIndex == -1) return;

                                        if (value == 'edit') {
                                          _showEditTaskDialog(taskIndex);
                                        } else if (value == 'delete') {
                                          _deleteTask(taskIndex);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit_outlined,
                                                size: 18,
                                              ),
                                              SizedBox(width: 10),
                                              Text('Edit'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete_outline,
                                                size: 18,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  task.category,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 13),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        task.date,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(task.status)
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        task.status,
                                        style: TextStyle(
                                          color: getStatusColor(task.status),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

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