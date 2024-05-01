import 'dart:convert';

class Item {
  String title;
  bool done;
  
  Item({required this.title, required this.done});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'done': done,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      title: map['title'] as String,
      done: map['done'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
