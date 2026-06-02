class GPARecord {
  final String id;
  final DateTime date;
  final double gpa;
  final int totalCourses;
  final int totalCreditHours;
  final String academicStanding;
  final List<Map<String, dynamic>> courses;
  
  GPARecord({
    required this.id,
    required this.date,
    required this.gpa,
    required this.totalCourses,
    required this.totalCreditHours,
    required this.academicStanding,
    required this.courses,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'gpa': gpa,
      'totalCourses': totalCourses,
      'totalCreditHours': totalCreditHours,
      'academicStanding': academicStanding,
      'courses': courses,
    };
  }
  
  factory GPARecord.fromJson(Map<String, dynamic> json) {
    return GPARecord(
      id: json['id'],
      date: DateTime.parse(json['date']),
      gpa: json['gpa'],
      totalCourses: json['totalCourses'],
      totalCreditHours: json['totalCreditHours'],
      academicStanding: json['academicStanding'],
      courses: List<Map<String, dynamic>>.from(json['courses']),
    );
  }
}
