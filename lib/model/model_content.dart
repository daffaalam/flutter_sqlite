import '../config/constant.dart';

class ModelContent {
  int id;
  String content;

  ModelContent({
    this.id,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      Constant.fieldId: id,
      Constant.fieldContent: content,
    };
  }
}
