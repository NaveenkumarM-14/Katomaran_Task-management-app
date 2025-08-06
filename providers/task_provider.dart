import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:task_management_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Task> get todoTasks => _tasks.where((task) => task.status == TaskStatus.todo).toList();
  List<Task> get inProgressTasks => _tasks.where((task) => task.status == TaskStatus.inProgress).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.status == TaskStatus.completed).toList();

  int get todoCount => todoTasks.length;
  int get inProgressCount => inProgressTasks.length;
  int get completedCount => completedTasks.length;
  int get totalCount => _tasks.length;

  double get completionPercentage {
    if (_tasks.isEmpty) return 0;
    return (completedCount / totalCount) * 100;
  }

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString('tasks');
      
      if (tasksJson != null) {
        final List<dynamic> decodedTasks = jsonDecode(tasksJson);
        _tasks = decodedTasks.map((task) => Task.fromJson(task)).toList();
      } else {
        // Add some demo tasks if none exist
        _tasks = [
          Task(
            id: '1',
            title: 'Task 1',
            description: 'UI/UX Design project',
            dueDate: DateTime.now().add(const Duration(days: 1)),
            status: TaskStatus.todo,
            createdAt: DateTime.now(),
          ),
          Task(
            id: '2',
            title: 'Task 2',
            description: 'UI/UX Design project',
            dueDate: DateTime.now().add(const Duration(days: 2)),
            status: TaskStatus.inProgress,
            createdAt: DateTime.now(),
          ),
          Task(
            id: '3',
            title: 'Task 3',
            description: 'UI/UX Design project',
            dueDate: DateTime.now().add(const Duration(days: 3)),
            status: TaskStatus.completed,
            createdAt: DateTime.now(),
          ),
        ];
        await _saveTasks();
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _saveTasks();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus newStatus) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: newStatus);
      await _saveTasks();
      notifyListeners();
    }
  }
}

  void addTask(Task task) {
    var _tasks;
    _tasks.add(task);
    notifyListeners();
    _saveTasks();
  }
  
  void notifyListeners() {
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    var _tasks;
    final taskListJson = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', taskListJson);
  }

