class Course {
  String id;
  String name;
  int creditHours;
  String grade;
  
  Course({
    required this.id,
    required this.name,
    required this.creditHours,
    required this.grade,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'creditHours': creditHours,
      'grade': grade,
    };
  }
  
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      creditHours: json['creditHours'],
      grade: json['grade'],
    );
  }
}
