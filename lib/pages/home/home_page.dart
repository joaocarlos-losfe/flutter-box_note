import 'dart:math';
import 'package:box_note/data/models.dart';
import 'package:box_note/styles/colors.dart';
import 'package:box_note/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> notes = [
    NoteModel(
      title: 'How to make your personal brand stand out online',
      text: '',
      cardColor: appColors[0],
    ),
    NoteModel(
      title: '12 eye-catching mobile wallpaper',
      text: '',
      cardColor: appColors[4],
    ),
    NoteModel(
      title: 'Beautiful weather app UL concepts we wish existed',
      text: '',
      cardColor: appColors[1],
    ),
    NoteModel(
      title: '10 excellent font pairing tools for designers',
      text: '',
      cardColor: appColors[2],
    ),
    NoteModel(
      title:
          'Spotify Reema Bhagat on product design, music, and the key to a happy career',
      text: '',
      cardColor: appColors[3],
    ),
    NoteModel(
      title: 'Design For Good: Join The Face Mask Challenge',
      text: '',
      cardColor: appColors[5],
    ),
    NoteModel(
      title: 'Starship next flight lates January',
      text: '',
      cardColor: appColors[6],
    ),
    NoteModel(
      title: 'The future of AI and machine learning',
      text: '',
      cardColor: appColors[3],
    ),
    NoteModel(
      title: 'Design trends to follow in 2024',
      text: '',
      cardColor: appColors[5],
    ),
    NoteModel(
      title: 'Exploring the new trends in UI/UX design',
      text: '',
      cardColor: appColors[1],
    ),
    NoteModel(
      title: 'Tech innovations changing the way we live',
      text: '',
      cardColor: appColors[2],
    ),
    NoteModel(
      title: 'How to stay productive working remotely',
      text: '',
      cardColor: appColors[3],
    ),
    NoteModel(
      title: 'The best programming languages to learn in 2024',
      text: '',
      cardColor: appColors[5],
    ),
    NoteModel(
      title: 'Why cybersecurity is more important than ever',
      text: '',
      cardColor: appColors[4],
    ),
    NoteModel(
      title: 'Cloud computing: The future of data storage',
      text: '',
      cardColor: appColors[0],
    ),
    NoteModel(
      title: 'Artificial intelligence in healthcare',
      text: '',
      cardColor: appColors[2],
    ),
    NoteModel(
      title: 'The evolution of web development technologies',
      text: '',
      cardColor: appColors[3],
    ),
    NoteModel(
      title: 'Sustainable technology for a better world',
      text: '',
      cardColor: appColors[1],
    ),
    NoteModel(
      title: 'The importance of mental health in the workplace',
      text: '',
      cardColor: appColors[0],
    ),
    NoteModel(
      title: 'Space exploration: Whats next after Mars?',
      text: '',
      cardColor: appColors[3],
    ),
  ];

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
          IconButton.filled(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-note'),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: StaggeredGrid.count(
          axisDirection: AxisDirection.down,
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: List.generate(
            notes.length,
            (index) {
              var note = notes[index];
              return StaggeredGridTile.count(
                crossAxisCellCount: note.cardSize()["width"] as int,
                mainAxisCellCount: note.cardSize()["height"] as num,
                child: Animate(
                  effects: [
                    MoveEffect(
                      delay: const Duration(milliseconds: 10),
                      curve: Curves.elasticOut,
                      duration:
                          Duration(milliseconds: 300 * (random.nextInt(5) + 3)),
                      begin: const Offset(0, 200),
                    ),
                  ],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(primaryRounded),
                    onTap: () {},
                    child: Card(
                      color: Color(notes[index].cardColor),
                      child: Padding(
                        padding: const EdgeInsets.all(primaryPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: Colors.black.withOpacity(0.5),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
