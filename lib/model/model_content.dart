import '../common/constant.dart';

class ModelContent {
  ModelContent({
    this.id,
    required this.content,
  });

  int? id;
  String content;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      Constant.fieldId: id,
      Constant.fieldContent: content,
    };
  }
}
