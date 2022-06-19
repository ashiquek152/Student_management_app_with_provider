import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:student_app_provider/db/models/student_model.dart';
import 'package:student_app_provider/screens/screen_home.dart';
import 'package:student_app_provider/widgets/container_decoration.dart';
import 'package:student_app_provider/widgets/text_filed.dart';

class ProfileStudent extends StatelessWidget {
  const ProfileStudent({Key? key, required this.data}) : super(key: key);

  final StudentModel data;

  @override
  Widget build(BuildContext context) {
    var encodedimage = data.image;
    var image = const Base64Decoder().convert(encodedimage);
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.off(() => HomeScreen())),
        elevation: 0,
        centerTitle: true,
        title: const Text('Student Details'),
        backgroundColor: scaffoldBG,
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          width: 350,
          height: 400,
          decoration: containerDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                CircleAvatar(backgroundImage: MemoryImage(image), radius: 70),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name    : ${data.name.toUpperCase()}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.red)),
                    Text('Age       : ${data.age}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Place    : ${data.place.toUpperCase()}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Batch    : ${data.batch.toUpperCase()}',
                        style: const TextStyle(fontSize: 20)),
                    Text('RegNo  : ${data.regNo.toUpperCase()}',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
