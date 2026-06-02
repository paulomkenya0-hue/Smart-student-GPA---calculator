import '../models/course.dart';
import '../utils/constants.dart';

class GPACalculator {
  static double calculateGPA(List<Course> courses) {
    double totalGradePoints = 0;
    int totalCredits = 0;
    
    for (var course in courses) {
      double gradePoint = AppConstants.gradePoints[course.grade] ?? 0;
      totalGradePoints += gradePoint * course.creditHours;
      totalCredits += course.creditHours;
    }
    
    if (totalCredits == 0) return 0;
    return totalGradePoints / totalCredits;
  }
  
  static int getTotalCreditHours(List<Course> courses) {
    return courses.fold(0, (sum, course) => sum + course.creditHours);
  }
}
