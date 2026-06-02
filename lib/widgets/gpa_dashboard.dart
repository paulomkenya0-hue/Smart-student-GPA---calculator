import 'package:flutter/material.dart';
import '../utils/constants.dart';

class GPADashboard extends StatelessWidget {
  final double gpa;
  final int totalCourses;
  final int totalCreditHours;
  
  const GPADashboard({
    super.key,
    required this.gpa,
    required this.totalCourses,
    required this.totalCreditHours,
  });
  
  @override
  Widget build(BuildContext context) {
    final standing = AppConstants.getAcademicStanding(gpa);
    final standingColor = AppConstants.getAcademicStandingColor(gpa);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Your GPA',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: gpa),
              duration: const Duration(milliseconds: 1000),
              builder: (context, double value, child) {
                return Text(
                  value.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: standingColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: standingColor),
              ),
              child: Text(
                standing,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: standingColor,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoCard('Courses', totalCourses.toString(), Icons.book),
                _buildInfoCard('Credits', totalCreditHours.toString(), Icons.credit_card),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
