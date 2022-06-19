import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String place;
  @HiveField(4)
  final String batch;
  @HiveField(5)
  final String regNo;
  @HiveField(6)
  String image;

  StudentModel({
    required this.name,
    required this.age,
    required this.place,
    required this.batch,
    required this.regNo,
    this.id,
    required this.image,
  });
}
