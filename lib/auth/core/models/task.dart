class Task {
  final int? id;
  final int? status;
  final String title;
  final  String createdAt;
  final String description;
  final String dropDownValue;

  Task({
    this.id,
    required this.title,
     required this.createdAt,
    this.status,
    required this.description,
    required this.dropDownValue,
  });

  Task.withId({
    this.id,
    required this.title,
    required this.createdAt,
    this.status,
    required this.description,
    required this.dropDownValue,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      createdAt: map['createdAt'].toString(),
      status: map['status'],
      description: map['description'].toString(),
      dropDownValue: map['todoType'].toString(),
    );
  }

  Task copyWith(
    int? status,
  ) {
    return Task(
      id: id,
      title: title,
      status: status??this.status,
      createdAt: createdAt,
      description: description,
      dropDownValue: dropDownValue,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['todoType'] = dropDownValue;
    map['status'] = status;
    map['title'] = title;
    map['createdAt'] = createdAt;
    map['description'] = description;

    return map;
  }
}
