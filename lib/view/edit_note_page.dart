import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';

class EditNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final Object i = ModalRoute.of(context)!.settings.arguments!;
    controller.titleController.text = controller.notes[i as int].title!;
    controller.contentController.text = controller.notes[i].content!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
          title: Text(
            "تعديل الملاحظة",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
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
                    hintText: "Title",
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
                    hintText: "Content",
                    hintStyle: TextStyle(
                      fontSize: 17,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.updateNote(
                controller.notes[i].id!, controller.notes[i].dateTimeCreated!);
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
