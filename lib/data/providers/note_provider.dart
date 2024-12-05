import 'package:box_note/data/models.dart';
import 'package:box_note/styles/colors.dart';
import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  final List<NoteModel> _notes = [
    NoteModel(
      title: 'Foco total em privacidade',
      text: '',
      cardColor: appColors[1],
    ),
    NoteModel(
      title: 'Mantenha precionado sobre uma nota para exclui-la',
      text: '',
      cardColor: appColors[4],
    ),
    NoteModel(
      title:
          'Exporte e Importe dados do seu dispositivo para seu armazenamento local',
      text: '',
      cardColor: appColors[2],
    ),
    NoteModel(
      title: 'Defina cor sua cor de cartão para uma melhor experiencia',
      text: '',
      cardColor: appColors[2],
    ),
    NoteModel(
      title: 'Simples com muita elegancia',
      text: '',
      cardColor: appColors[0],
    ),
    NoteModel(
      title: 'Armazenamento de dados de forma local',
      text: '',
      cardColor: appColors[1],
    ),
  ];

  List<NoteModel> get notes => _notes;

  set addNote(NoteModel note) {
    _notes.insert(0, note);

    notifyListeners();
  }

  updateNote(NoteModel note, int index) {
    _notes[index] = note;

    notifyListeners();
  }

  removeNote(int index) {
    _notes.removeAt(index);

    notifyListeners();
  }
}
