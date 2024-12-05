import 'dart:math';

import 'package:box_note/data/models.dart';
import 'package:box_note/data/providers/note_provider.dart';
import 'package:box_note/styles/colors.dart';
import 'package:box_note/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final bool isEditing;
  final int noteIndex;

  const NotePage({
    super.key,
    this.isEditing = false,
    this.noteIndex = -1,
  });

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late int cardColor;
  Random random = Random();

  var titleController = TextEditingController();
  var textController = TextEditingController();

  Future openColorSelector() async {
    var result = await buildColorSelector();
    if (result != null) setState(() => cardColor = result);
  }

  saveNote() {
    var title = titleController.text;
    var text = textController.text;

    if (title.isNotEmpty && title.isNotEmpty) {
      titleController.clear();
      textController.clear();

      var note = NoteModel(title: title, text: text, cardColor: cardColor);

      widget.isEditing
          ? context.read<NoteProvider>().updateNote(note, widget.noteIndex)
          : context.read<NoteProvider>().addNote = note;

      ScaffoldMessenger.of(context).showSnackBar(buildSaveNoteSnackMessage());
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.noteIndex > -1) {
      var note = context.read<NoteProvider>().notes[widget.noteIndex];
      titleController.text = note.title;
      textController.text = note.text;
      cardColor = note.cardColor;
    } else {
      cardColor = appColors[random.nextInt(appColors.length)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, '/home', (_) => false),
            icon: const Icon(Icons.chevron_left)),
        actions: [
          IconButton.filled(
            onPressed: () => openColorSelector(),
            icon: const Icon(Icons.color_lens_outlined),
          ),
          FilledButton(
            onPressed: () => saveNote(),
            child: const Text('Salvar'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 3),
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPadding / 2,
          vertical: primaryPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(cardColor),
                borderRadius: BorderRadius.circular(primaryRounded),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: TextField(
                controller: titleController,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 24, color: Colors.black),
                minLines: 2,
                maxLines: 3,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 60,
                decoration: const InputDecoration(
                  counterText: '',
                  hintText: 'Titulo',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Color(basicColorsDark[1]),
                borderRadius: BorderRadius.circular(primaryRounded),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: TextField(
                controller: textController,
                cursorColor: Colors.white,
                style: const TextStyle(fontSize: 16),
                minLines: 10,
                maxLines: (MediaQuery.of(context).size.height / 2).ceil(),
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  hintText: 'Digite algo',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int?> buildColorSelector() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(primaryPadding),
                child: Text(
                  'Defina uma cor de cartão',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    appColors.length,
                    (index) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context, appColors[index]),
                        child: Animate(
                          effects: const [
                            MoveEffect(
                              begin: Offset(-300, 0),
                              duration: Duration(milliseconds: 600),
                              curve: Curves.fastOutSlowIn,
                            )
                          ],
                          child: Container(
                            margin: const EdgeInsets.all(primaryMargin),
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(secondaryRounded),
                              color: Color(appColors[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  SnackBar buildSaveNoteSnackMessage() {
    return SnackBar(
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nota salva com sucesso',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(width: primaryMargin),
          Icon(Icons.check, color: Colors.black)
        ],
      ),
      backgroundColor: Color(cardColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(primaryRounded),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(primaryMargin),
    );
  }
}
