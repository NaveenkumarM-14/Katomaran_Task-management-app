import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/providers/task_provider.dart';
import 'package:task_management_app/theme/app_theme.dart';
import 'package:intl/intl.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completionPercentage = taskProvider.completionPercentage;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: CircularPercentIndicator(
                    radius: 125.0,
                    lineWidth: 30.0,
                    percent: completionPercentage / 100,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${completionPercentage.toInt()}%',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 50,
                            color: Color(0xBB000000),
                          ),
                        ),
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0x4D000000),
                          ),
                        ),
                      ],
                    ),
                    progressColor: AppTheme.primaryLightColor,
                    backgroundColor: AppTheme.accentColor,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                const SizedBox(height: 24),
                _buildStatusFilters(context),
                const SizedBox(height: 24),
                _buildTaskCreationSection(context),
                const SizedBox(height: 24),
                _buildWeekdaySelector(context),
                const SizedBox(height: 80),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'My Tasks',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFilters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatusFilter(context, 'To Do', TaskStatus.todo),
        _buildStatusFilter(context, 'In Progress', TaskStatus.inProgress, isSelected: true),
        _buildStatusFilter(context, 'Completed', TaskStatus.completed),
      ],
    );
  }

  Widget _buildStatusFilter(BuildContext context, String label, TaskStatus status, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x33FFFFFF) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: status == TaskStatus.todo
                  ? const Color(0xFFEDFFE5)
                  : status == TaskStatus.inProgress
                      ? AppTheme.primaryLightColor
                      : AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: isSelected ? const Color(0x80000000) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCreationSection(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Create and Check',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Color(0xCC000000),
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Daily Task',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Color(0xCC000000),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildWeekdaySelector(BuildContext context) {
    final now = DateTime.now();
    final currentDay = now.weekday;
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final day = weekStart.add(Duration(days: index));
        final isToday = index + 1 == currentDay;
        
        return _buildDayItem(context, day, isToday);
      }),
    );
  }

  Widget _buildDayItem(BuildContext context, DateTime date, bool isSelected) {
    final dayName = DateFormat('E').format(date).substring(0, 2);
    final dayNumber = date.day.toString();
    
    return Column(
      children: [
        Text(
          dayName,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: isSelected ? Colors.white : const Color(0x80000000),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: isSelected ? 60 : 30,
          height: isSelected ? 100 : 30,
          decoration: BoxDecoration(
            gradient: isSelected ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              dayNumber,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
