import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task.dart';
import 'package:task_management_app/models/user.dart';
import 'package:task_management_app/providers/auth_provider.dart';
import 'package:task_management_app/providers/task_provider.dart';
import 'package:task_management_app/screens/splash_screen.dart';
import 'package:task_management_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Task Management App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
