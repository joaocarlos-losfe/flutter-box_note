import 'dart:math';
import 'package:box_note/data/providers/note_provider.dart';
import 'package:box_note/pages/home/note_page.dart';
import 'package:box_note/styles/colors.dart';
import 'package:box_note/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();
  int getRandomColorFromList() {
    final random = Random();
    return appColors[random.nextInt(appColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(basicColorsDark[0]),
        appBar: AppBar(
          title: const Text('BoxNote'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/note-page'),
          child: const Icon(Icons.add),
        ),
        body: Consumer<NoteProvider>(
          builder: (context, provider, _) => provider.notes.isEmpty
              ? buildEmptyNotesView()
              : SingleChildScrollView(
                  child: StaggeredGrid.count(
                    axisDirection: AxisDirection.down,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      provider.notes.length,
                      (index) {
                        var note = provider.notes[index];
                        return StaggeredGridTile.count(
                          crossAxisCellCount: note.cardSize()["width"] as int,
                          mainAxisCellCount: note.cardSize()["height"] as num,
                          child: Animate(
                            effects: [
                              MoveEffect(
                                delay: const Duration(milliseconds: 10),
                                curve: Curves.elasticOut,
                                duration: Duration(
                                    milliseconds:
                                        300 * (random.nextInt(5) + 3)),
                                begin: const Offset(0, 200),
                              ),
                            ],
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.circular(primaryRounded),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotePage(
                                          isEditing: true, noteIndex: index))),
                              onLongPress: () => provider.removeNote(index),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  color: Color(provider.notes[index].cardColor),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(primaryPadding),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          note.title,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: note.titleFontSize(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          note.formatedDatetime(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ));
  }

  Widget buildEmptyNotesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie_empty.json'),
        const Text(
          'Você não possui nenhuma nota.\nToque em "+" para adicionar',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
