import 'dart:math';

import 'package:box_note/styles/colors.dart';
import 'package:box_note/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var tileColor = appColors[0];
  Random random = Random();

  Future openColorSelector() async {
    var result = await buildColorSelector();

    if (result != null) setState(() => tileColor = result);
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
            onPressed: () {},
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
            Animate(
              effects: [
                MoveEffect(
                  curve: Curves.elasticOut,
                  duration:
                      Duration(milliseconds: 450 * (random.nextInt(5) + 2)),
                  begin: const Offset(-200, 0),
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: Color(tileColor),
                  borderRadius: BorderRadius.circular(primaryRounded),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: const TextField(
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  minLines: 2,
                  maxLines: 3,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLength: 60,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Titulo',
                    hintStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Animate(
              effects: [
                MoveEffect(
                  curve: Curves.elasticOut,
                  duration:
                      Duration(milliseconds: 450 * (random.nextInt(5) + 2)),
                  begin: const Offset(-200, 0),
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  color: Color(basicColorsDark[1]),
                  borderRadius: BorderRadius.circular(primaryRounded),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: TextField(
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
                child: Text('Defina uma cor de cartão'),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    appColors.length,
                    (index) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context, appColors[index]),
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
}
