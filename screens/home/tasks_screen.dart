import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/providers/task_provider.dart';
import 'package:task_management_app/theme/app_theme.dart';
import 'package:task_management_app/widgets/task_card.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final now = DateTime.now();
    final dateFormat = DateFormat('MMM d, yyyy');
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Tasks',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: AppTheme.textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFF697E99),
                        ),
                      ),
                      Text(
                        dateFormat.format(now),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Color(0xFF697E99),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: taskProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : taskProvider.tasks.isEmpty
                        ? const Center(
                            child: Text(
                              'No tasks yet. Add your first task!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: AppTheme.textLightColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: taskProvider.tasks.length,
                            itemBuilder: (context, index) {
                              final task = taskProvider.tasks[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: TaskCard(
                                  task: task,
                                  onDelete: () => _deleteTask(context, task.id),
                                ),
                              );
                            },
                          ),
              ),
              const SizedBox(height: 16),
              _buildTaskSummary(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskSummary(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    
    return Column(
      children: [
        _buildTaskCategory(
          context,
          'To Do',
          taskProvider.todoCount,
          taskProvider.inProgressCount,
          const Color(0xFFEDF1F5),
          Icons.access_time,
          Colors.black,
        ),
        const SizedBox(height: 16),
        _buildTaskCategory(
          context,
          'in Progress',
          taskProvider.inProgressCount,
          taskProvider.todoCount,
          AppTheme.primaryLightColor,
          Icons.trending_up,
          Colors.white,
        ),
        const SizedBox(height: 16),
        _buildTaskCategory(
          context,
          'Completed',
          taskProvider.completedCount,
          taskProvider.totalCount,
          AppTheme.primaryColor,
          Icons.check,
          Colors.white,
        ),
      ],
    );
  }

  Widget _buildTaskCategory(
    BuildContext context,
    String title,
    int taskCount,
    int secondaryCount,
    Color iconBgColor,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xBB000000),
              ),
            ),
            Row(
              children: [
                Text(
                  '$taskCount Task now',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF697E99),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title == 'To Do'
                      ? '$secondaryCount in Progress'
                      : title == 'in Progress'
                          ? '$secondaryCount Started'
                          : '$secondaryCount Completed',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF697E99),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _deleteTask(BuildContext context, String taskId) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.deleteTask(taskId);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}

   