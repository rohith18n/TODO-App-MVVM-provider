class Note {
  String id;
  String subtitle;
  String title;
  String time;
  int image;
  bool isDone;

  Note(
    this.id,
    this.subtitle,
    this.time,
    this.image,
    this.title,
    this.isDone,
  );

  // Convert a Note object into a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subtitle': subtitle,
      'title': title,
      'time': time,
      'image': image,
      'isDone': isDone,
    };
  }

  // Create a Note object from a Map
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'],
      json['subtitle'],
      json['time'],
      json['image'],
      json['title'],
      json['isDone'],
    );
  }
}
