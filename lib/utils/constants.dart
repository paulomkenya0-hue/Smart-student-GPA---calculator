class AppConstants {
  static const String appName = 'Smart GPA Calculator';
  static const String gpaHistoryKey = 'gpa_history';
  
  static const Map<String, double> gradePoints = {
    'A': 5.0,
    'B+': 4.0,
    'B': 3.0,
    'C+': 2.5,
    'C': 2.0,
    'D': 1.0,
    'F': 0.0,
  };
  
  static const List<String> grades = ['A', 'B+', 'B', 'C+', 'C', 'D', 'F'];
  
  static String getAcademicStanding(double gpa) {
    if (gpa >= 4.4 && gpa <= 5.0) return 'Excellent';
    if (gpa >= 3.5 && gpa <= 4.39) return 'Very Good';
    if (gpa >= 2.7 && gpa <= 3.49) return 'Good';
    if (gpa >= 2.0 && gpa <= 2.69) return 'Pass';
    return 'Probation';
  }
  
  static Color getAcademicStandingColor(double gpa) {
    if (gpa >= 4.4) return Colors.green;
    if (gpa >= 3.5) return Colors.lightGreen;
    if (gpa >= 2.7) return Colors.blue;
    if (gpa >= 2.0) return Colors.orange;
    return Colors.red;
  }
}
