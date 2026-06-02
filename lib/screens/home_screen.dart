import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../models/course.dart';
import '../models/gpa_record.dart';
import '../services/gpa_calculator.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../utils/theme_provider.dart';
import '../widgets/course_card.dart';
import '../widgets/gpa_dashboard.dart';
import '../widgets/custom_dialog.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Course> _courses = [];
  final StorageService _storageService = StorageService();
  bool _isDarkMode = false;
  
  @override
  void initState() {
    super.initState();
    _addInitialCourse();
  }
  
  void _addInitialCourse() {
    _courses.add(Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      creditHours: 3,
      grade: 'A',
    ));
  }
  
  void _addCourse() {
    setState(() {
      _courses.add(Course(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
        creditHours: 3,
        grade: 'A',
      ));
    });
  }
  
  void _updateCourse(Course updatedCourse) {
    setState(() {
      final index = _courses.indexWhere((c) => c.id == updatedCourse.id);
      if (index != -1) {
        _courses[index] = updatedCourse;
      }
    });
  }
  
  void _removeCourse(String id) {
    setState(() {
      _courses.removeWhere((course) => course.id == id);
      if (_courses.isEmpty) {
        _addInitialCourse();
      }
    });
  }
  
  void _resetAll() {
    setState(() {
      _courses = [];
      _addInitialCourse();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All courses have been reset')),
    );
  }
  
  Future<void> _saveToHistory() async {
    if (_courses.isEmpty || _courses.any((c) => c.name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all course names before saving')),
      );
      return;
    }
    
    final gpa = GPACalculator.calculateGPA(_courses);
    final totalCredits = GPACalculator.getTotalCreditHours(_courses);
    final standing = AppConstants.getAcademicStanding(gpa);
    
    final record = GPARecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      gpa: gpa,
      totalCourses: _courses.length,
      totalCreditHours: totalCredits,
      academicStanding: standing,
      courses: _courses.map((c) => c.toJson()).toList(),
    );
    
    final history = await _storageService.loadHistory();
    history.insert(0, record);
    await _storageService.saveHistory(history);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('GPA calculation saved to history!')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final gpa = GPACalculator.calculateGPA(_courses);
    final totalCredits = GPACalculator.getTotalCreditHours(_courses);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart GPA Calculator'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final isDark = themeProvider.themeMode != ThemeMode.dark;
              themeProvider.toggleTheme(isDark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
              if (result == true) {
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          GPADashboard(
            gpa: gpa,
            totalCourses: _courses.length,
            totalCreditHours: totalCredits,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                return CourseCard(
                  course: _courses[index],
                  index: index,
                  onUpdate: _updateCourse,
                  onDelete: () => _removeCourse(_courses[index].id),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _addCourse,
                icon: const Icon(Icons.add),
                label: const Text('Add Course'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => CustomDialog.showResetDialog(context, _resetAll),
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => CustomDialog.showSaveDialog(context, _saveToHistory),
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
