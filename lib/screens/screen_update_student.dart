
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/db/models/student_model.dart';
import 'package:student_app_provider/provider/student_model_provider.dart';
import 'package:student_app_provider/screens/screen_home.dart';
import 'package:student_app_provider/widgets/text_filed.dart';

// ignore: must_be_immutable
class EditStudent extends StatelessWidget {
  final StudentModel data;
   bool editorClicked ;

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _regController = TextEditingController();
  final _batchController = TextEditingController();

  // final imageController =Get.put(ImageController()) ;

  EditStudent({Key? key, required this.data, required this.editorClicked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    _nameController.text = data.name;
    _ageController.text = data.age;
    _placeController.text = data.place;
    _regController.text = data.regNo;
    _batchController.text = data.batch;

    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        leading: IconButton(icon:const Icon( Icons.arrow_back),onPressed: ()=>Get.off(()=>HomeScreen())),
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit student details',
          style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor:scaffoldBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [

              Consumer<ImageNotifier>(builder: (context, value, child) {
                  if (editorClicked == true) {
                  stringOfimg = data.image;
                  editorClicked = false;
                }
                return CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      MemoryImage(const Base64Decoder().convert(stringOfimg))
                );
              },),
              IconButton(
                onPressed: () async =>Provider.of<ImageNotifier>(context,listen: false).pickGalleryImage(),
                icon: const Icon(
                  Icons.camera,
                  color: Colors.red)),
              const SizedBox(height: 20),
                Textfeild(regController: _nameController, hintText: "Name",keyboardType: TextInputType.name),
                Textfeild(regController: _ageController, hintText: "Age",keyboardType: TextInputType.number),
                Textfeild(regController: _placeController, hintText: "Place"),
                Textfeild(regController: _batchController, hintText: "Batch"),
                Textfeild(regController: _regController, hintText: "Reg No",keyboardType: TextInputType.number),
              Center(
                child: ElevatedButton.icon(
                    onPressed: () => updatebuttonClick(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Update')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updatebuttonClick(BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final batch = _batchController.text;
    final reg = _regController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        batch.isEmpty ||
        reg.isEmpty ||
        stringOfimg.isEmpty) {
      return;
    }
    final student = StudentModel(
        age: age,
        batch: batch,
        name: name,
        place: place,
        regNo: reg,
        image: stringOfimg,
        id: data.id);
     await Provider.of<ScreenProvider>(context,listen: false).updateData(student);
    Get.snackbar("Updated !", "Data upadated successfully",
    barBlur: 50.0,
    backgroundColor: Colors.black45,
        colorText:Colors.white );
    clearFields();
    Get.off(() => HomeScreen());
  }

  void clearFields() {
    _nameController.text = '';
    _ageController.text = '';
    _placeController.text = '';
    _batchController.text = '';
    _regController.text = '';
    stringOfimg = '';
  }
}
