import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_provider/db/models/student_model.dart';



class ScreenProvider extends ChangeNotifier {

List<StudentModel> searchData = [];
List<StudentModel> studentModelList = [];


  Future<void> addstudentData(StudentModel value) async {
    final studentDataBase =
    await Hive.openBox<StudentModel>('Student_Data_Base');
    final id = await studentDataBase.add(value);
    value.id = id;
    studentDataBase.put(value.id, value);
    studentModelList.clear();
    studentModelList.addAll(studentDataBase.values);
    notifyListeners();

  }

  Future<void> allStudentslist() async {
    final studentDataBase =
    await Hive.openBox<StudentModel>('Student_Data_Base');
    studentModelList.clear();
    studentModelList.addAll(studentDataBase.values);
    notifyListeners();
  }

  void deleteData(int id) async {
    final studentDataBase =
        await Hive.openBox<StudentModel>('Student_Data_Base');
    await studentDataBase.delete(id);
    allStudentslist();
    notifyListeners();

  }

  updateData(StudentModel value) async {
    final studentDataBase =
        await Hive.openBox<StudentModel>('Student_Data_Base');
    await studentDataBase.put(value.id, value);
    allStudentslist();
    notifyListeners();

  }

  searchInData(String value) {
    searchData.clear();
    for (var items in studentModelList) {
      if (items.name.toString().toLowerCase().contains(value.toLowerCase())) {
        StudentModel findings = StudentModel(
          name: items.name,
          age: items.age,
          place: items.place,
          batch: items.batch,
          image: items.image,
          regNo: items.regNo,
        );
        searchData.add(findings);
        notifyListeners();
      }
    }
  }
}

File? image; //File is a reference to a file on  system storatge (path of the file)
String stringOfimg = '';

class ImageNotifier extends ChangeNotifier {
  pickGalleryImage() async {
    final galleryImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (galleryImage == null) {
      return;
    } else {
      image = File(galleryImage.path);
      notifyListeners();
      final bytes = File(galleryImage.path).readAsBytesSync();
      stringOfimg = base64Encode(bytes);
      notifyListeners();
    }
  }
  pickCameraImage() async {
    final galleryImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (galleryImage == null) {
      return;
    } else {
      image = File(galleryImage.path);
      notifyListeners();
      final bytes = File(galleryImage.path).readAsBytesSync();
      stringOfimg = base64Encode(bytes);
      notifyListeners();
    }
  }
}