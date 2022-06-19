
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/models/student_model.dart';
import 'package:student_app_provider/provider/student_model_provider.dart';
import 'package:student_app_provider/screens/screen_add_student.dart';
import 'package:student_app_provider/screens/screen_search_student.dart';
import 'package:student_app_provider/widgets/students_list.dart';
import 'package:student_app_provider/widgets/text_filed.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  StudentModel? data;

  @override
  Widget build(BuildContext context) {
    context.read<ScreenController>().allStudentslist();
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child: Text(
          'STUDENTS LIST',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScreenController>(context,listen: false).searchData.clear();
                Get.to(() => SearchPage());
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: scaffoldBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Consumer<ScreenController>(
            builder: (context, data, child) =>StudentsList(data: data)
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => Addstudent()),
        backgroundColor: Colors.black,
        tooltip: 'Add New',
        child: const Icon(Icons.add),
      ),
    );
  }
}
