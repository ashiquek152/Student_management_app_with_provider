
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/provider/student_model_provider.dart';
import 'package:student_app_provider/screens/screen_home.dart';
import 'package:student_app_provider/widgets/students_list.dart';
import 'package:student_app_provider/widgets/text_filed.dart';


class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon( Icons.arrow_back),onPressed: ()=>Get.off(()=>HomeScreen())),
        elevation: 0,
        backgroundColor: scaffoldBG,
        title: const Text("Search student details"),
        centerTitle: true,
      ),
      backgroundColor: scaffoldBG,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) {
                        Provider.of<ScreenController>(context,listen: false).searchInData(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Provider.of<ScreenController>(context).searchData.isNotEmpty? 
            Expanded(child: Consumer<ScreenController>(
              builder: (context, data, child) =>StudentsList(data: data,search: true))):
              Container(),
          ],
        ),
      ),
    );
  }
}
