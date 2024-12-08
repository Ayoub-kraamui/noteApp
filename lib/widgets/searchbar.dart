import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/model/Note_model.dart';
import 'package:note_app/view/note_detail_page.dart';

class SearchBars extends SearchDelegate {
  final NoteController controller = Get.find<NoteController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            Get.back();
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
            color: Colors.orange,
          ))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear,
          color: Colors.orange,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Note> suggestionList = query.isEmpty
        ? controller.notes
        : controller.notes.where(
            (p) {
              return p.title!.toLowerCase().contains(query.toLowerCase()) ||
                  p.content!.toLowerCase().contains(query.toLowerCase());
            },
          ).toList();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: GridView.builder(
          itemCount: suggestionList.length,
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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(10, 10),
                          blurRadius: 15)
                    ]),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestionList[index].title!,
                      style: TextStyle(
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
                      suggestionList[index].content!,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      suggestionList[index].dateTimeEdited!,
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
}
