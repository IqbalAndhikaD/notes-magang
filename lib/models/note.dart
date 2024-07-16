class Note{
  int? id;
  String title, description;
  DateTime createAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'createAt': createAt.toString(),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createAt: DateTime.parse(map['createAt']),
    );
  }
}