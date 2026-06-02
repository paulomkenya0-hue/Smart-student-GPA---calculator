import 'package:flutter/material.dart';
import '../models/course.dart';
import '../utils/constants.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final int index;
  final Function(Course) onUpdate;
  final VoidCallback onDelete;
  
  const CourseCard({
    super.key,
    required this.course,
    required this.index,
    required this.onUpdate,
    required this.onDelete,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Course Name',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: course.name,
                    onChanged: (value) {
                      onUpdate(Course(
                        id: course.id,
                        name: value,
                        creditHours: course.creditHours,
                        grade: course.grade,
                      ));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Credit Hours',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: course.creditHours.toString(),
                    onChanged: (value) {
                      int credits = int.tryParse(value) ?? 1;
                      if (credits < 1) credits = 1;
                      onUpdate(Course(
                        id: course.id,
                        name: course.name,
                        creditHours: credits,
                        grade: course.grade,
                      ));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Grade',
                      border: OutlineInputBorder(),
                    ),
                    value: course.grade,
                    items: AppConstants.grades.map((grade) {
                      return DropdownMenuItem(
                        value: grade,
                        child: Text(grade),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onUpdate(Course(
                          id: course.id,
                          name: course.name,
                          creditHours: course.creditHours,
                          grade: value,
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
