import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/models/student_model.dart';
import 'package:student_app_provider/provider/student_model_provider.dart';
import 'package:student_app_provider/screens/screen_student_profile.dart';
import 'package:student_app_provider/screens/screen_update_student.dart';
import 'package:student_app_provider/widgets/container_decoration.dart';

// ignore: must_be_immutable
class StudentsList extends StatelessWidget {
  StudentsList({Key? key, required this.data, required this.search})
      : super(key: key);

  final ScreenController data;
  final bool search;
  dynamic images;

  @override
  Widget build(BuildContext context) {
    List<StudentModel> listData = search == true
            ? Provider.of<ScreenController>(context).searchData
            : Provider.of<ScreenController>(context).studentModelList;
          
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemCount: listData.length,
      itemBuilder: (context, index) {

        final encodedimg = listData[index].image;
        images = const Base64Decoder().convert(encodedimg);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            alignment: const Alignment(0, 0),
            height: 80,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: containerDecoration(),
            child: Slidable(
              direction: Axis.horizontal,
              key: Key(listData[index].id.toString()),
              startActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                IconButton(
                    onPressed: () => Get.to(() => EditStudent(
                        data: listData[index],
                        editorClicked: true)),
                    icon: const Icon(Icons.edit, color: Colors.amber)),
                IconButton(
                    onPressed: () => Get.defaultDialog(
                        title: "Delete",
                        titleStyle: const TextStyle(color: Colors.red),
                        middleText: "Are you sure ?",
                        confirm: TextButton(
                            onPressed: () {
                              context
                                  .read<ScreenController>()
                                  .deleteData(listData[index].id!);
                              Get.back();
                            },
                            child: const Text("Yes")),
                        cancel: TextButton(
                            onPressed: () => Get.back(),
                            child: const Text("No"))),
                    icon: const Icon(Icons.delete_forever, color: Colors.red)),
              ]),
              child: ListTile(
                onTap: () => Get.to(
                    () => ProfileStudent(data:listData[index])),
                tileColor: Colors.white,
                title: Text(listData[index].name),
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: MemoryImage(images),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
