class Note {
  final int? id;
  final String? title;
  final String? content;
  final String? dateTimeEdited;
  final String? dateTimeCreated;

  Note(
      {this.id,
      this.title,
      this.content,
      this.dateTimeEdited,
      this.dateTimeCreated});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
      "dateTimeCreated": dateTimeCreated,
    };
  }
}
