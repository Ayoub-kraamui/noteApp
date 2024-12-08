import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';

class AddNewNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "إنشاء مذكرة جديدة",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: controller.titleController,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "عنوان",
                      hintStyle: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        letterSpacing: 1,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    controller: controller.contentController,
                    decoration: InputDecoration(
                      hintText: "محتوى",
                      hintStyle: TextStyle(
                        fontSize: 22,
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            controller.addNoteToDatabase();
          },
          child: Icon(
            Icons.check,
          ),
        ),
      ),
    );
  }
}
