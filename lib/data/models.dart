import 'package:intl/intl.dart';

class NoteModel {
  String title;
  String text;
  int cardColor;
  final DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  NoteModel({
    required this.title,
    required this.text,
    required this.cardColor,
  });

  Map<String, int> cardSize() {
    switch (title.length) {
      case >= 40:
        return {"width": 2, "height": 3};

      default:
        return {"width": 2, "height": 2};
    }
  }

  double titleFontSize() {
    return title.length >= 60
        ? 20
        : title.length >= 40
            ? 22
            : 16;
  }

  String formatedDatetime() {
    return DateFormat.yMd().add_jms().format(updatedAt);
  }
}
