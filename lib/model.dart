class Model {
  int id;
  String content;

  Model({
    this.id,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "content": content,
    };
  }
}
