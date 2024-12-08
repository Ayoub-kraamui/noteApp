import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/widgets/alarm_dialog.dart';
import 'package:note_app/widgets/searchbar.dart';
import 'add_new_note_page.dart';
import 'note_detail_page.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());
  
  Widget emptyNotes() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/note.json'),
          SizedBox(
            height: 50,
          ),
          Text(
            "لا يوجد لديك اي ملاحظة",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: GridView.builder(
          itemCount: controller.notes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.grid ? 2 : 1,
              crossAxisSpacing: controller.grid ? 15.0 : 0,
              mainAxisSpacing: controller.grid ? 20.0 : 5.0,
              mainAxisExtent: 150),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  NoteDetailPage(),
                  arguments: index,
                );
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete the note?",
                      confirmFunction: () {
                        controller.deleteNote(controller.notes[index].id!);
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //todo add note(title) from index
                      controller.notes[index].title!,
                      style:const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      //todo add note(content) from index
                      controller.notes[index].content!,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.notes[index].dateTimeEdited!,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ملاحضات",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
          leading: GetBuilder<NoteController>(
              builder: (_) => IconButton(
                  icon: controller.grid
                      ? Icon(
                          Icons.grid_view_rounded,
                          color: Colors.orange,
                        )
                      : Icon(
                          Icons.menu_rounded,
                          color: Colors.orange,
                        ),
                  onPressed: () {
                    controller.updategrid();
                  })),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBars());
              },
            ),
            PopupMenuButton(
              onSelected: (val) {
                if (val == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogWidget(
                        contentText:
                            "Are you sure you want to delete all notes?",
                        confirmFunction: () {
                          controller.deleteAllNotes();
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    },
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    "Delete All Notes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: GetBuilder<NoteController>(
          builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Get.to(() => AddNewNotePage());
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
