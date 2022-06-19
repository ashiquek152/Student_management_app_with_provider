import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_provider/db/models/student_model.dart';
import 'package:student_app_provider/provider/student_model_provider.dart';
import 'package:student_app_provider/screens/screen_home.dart';
import 'package:student_app_provider/widgets/text_filed.dart';
import 'package:provider/provider.dart';


class Addstudent extends StatelessWidget {
  Addstudent({Key? key, this.data}) : super(key: key);

  final StudentModel? data;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _placeController = TextEditingController();
  final _regController = TextEditingController();
  final _batchController = TextEditingController();

  // final imageController = Get.put(ImageController());
  final formvalidationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBG,
      appBar: AppBar(
        leading: IconButton(icon:const Icon( Icons.arrow_back),onPressed: ()=>Get.off(()=>HomeScreen())),
        title: const Text('Add student details'),
        backgroundColor:scaffoldBG,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formvalidationKey,
            child: ListView(
              children: [
                Consumer<ImageNotifier>(builder: (context, value, child) {
                     return Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "images/blank-profile-picture-973460_1280.webp"))),
                      child: stringOfimg.trim().isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(const Base64Decoder()
                                  .convert(stringOfimg)),
                            )
                          : Container(),
                    ),
                  );
                },),
                IconButton(
                    onPressed: () async =>Provider.of<ImageNotifier>(context,listen: false).pickimage(),
                    icon:
                        const Icon(Icons.camera, color: Colors.red, size: 20)),
                const SizedBox(height: 20),
                Textfeild(regController: _nameController, hintText: "Name",keyboardType: TextInputType.name),
                Textfeild(regController: _ageController, hintText: "Age",keyboardType: TextInputType.number),
                Textfeild(regController: _placeController, hintText: "Place",keyboardType: TextInputType.text),
                Textfeild(regController: _batchController, hintText: "Batch",keyboardType: TextInputType.text),
                Textfeild(regController: _regController, hintText: "Reg No",keyboardType: TextInputType.number),
                Center(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (formvalidationKey.currentState!.validate()) {
                          addbuttonclick(context);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('ADD')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addbuttonclick(BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final batch = _batchController.text;
    final reg = _regController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        place.isEmpty ||
        batch.isEmpty ||
        reg.isEmpty) {
      return;
    } else if (stringOfimg.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Choose an image'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
      ));
    } else {
      final student = StudentModel(
        age: age,
        batch: batch,
        name: name,
        place: place,
        regNo: reg,
        image: stringOfimg,
      );
     await Provider.of<ScreenController>(context,listen: false).addstudentData(student);
      Get.snackbar("Added", "Data added successfully", barBlur: 50.0,
    backgroundColor: Colors.black45,
        colorText:Colors.white );
      clearFields();
      Get.offAll(() => HomeScreen());
    }
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
