// ignore_for_file: use_build_context_synchronously
import 'dart:math';
import 'package:todo/constants/constant_colors.dart';

import '../models/todo_model.dart';
import 'package:flutter/material.dart';
import '../database/todo_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/widgets/custom_text_field_widget.dart';
import 'package:todo/widgets/custom_dailog_widget.dart';

class AddTODOWidget {
  int minutes = 10;
  int seconds = 0;
  AddTODOWidget();
  Random random = Random();

  bootomSheetWidget(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    showModalBottomSheet<void>(
      backgroundColor: ConstantColors.primaryColor,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextFieldWidget(
                    textEditingController: textEditingController,
                  ),
                ),
                DefaultTextStyle.merge(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                    child: CupertinoTimerPicker(
                      alignment: Alignment.center,
                      initialTimerDuration: const Duration(minutes: 10),
                      mode: CupertinoTimerPickerMode.ms,
                      onTimerDurationChanged: (Duration changedtimer) {
                        minutes = changedtimer.inMinutes;
                        seconds = changedtimer.inSeconds.remainder(60);
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                    color: Colors.black,
                    child: const Text(
                      'Add TODO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () async {
                      int id = DateTime.now().millisecondsSinceEpoch;
                      if (textEditingController.text.length < 10) {
                        CustomDailogWidget.showCustomDailog(
                            context, 'Invalid TODO', 'Todo title too small.');
                        return;
                      }
                      Duration currentDuration =
                          Duration(minutes: minutes, seconds: seconds);
                      const Duration maxDuration =
                          Duration(minutes: 10, seconds: 0);
                      const Duration minDuration =
                          Duration(minutes: 0, seconds: 1);
                      if (currentDuration.inSeconds > maxDuration.inSeconds) {
                        CustomDailogWidget.showCustomDailog(
                            context,
                            'Invalid Time Limit',
                            'Time limit should not be more than 10 minutes.');
                        return;
                      }
                      if (currentDuration.inSeconds < minDuration.inSeconds) {
                        CustomDailogWidget.showCustomDailog(
                            context,
                            'Invalid Time Limit',
                            'Time limit should not be less than 1 second.');
                        return;
                      }
                      await TodoDatabase.addTodo(
                        id: id.toString(),
                        todo: TodoModel(
                          id: id.toString(),
                          title: textEditingController.text,
                          minutes: minutes.toString(),
                          seconds: seconds.toString(),
                          startMinute: minutes.toString(),
                          startSecond: seconds.toString(),
                          colorIndex: random.nextInt(6).toString(),
                        ),
                      );
                      Provider.of<TodoProvider>(context, listen: false)
                          .addListItem(
                        TodoModel(
                            id: id.toString(),
                            title: textEditingController.text,
                            minutes: minutes.toString(),
                            seconds: seconds.toString(),
                            startMinute: minutes.toString(),
                            startSecond: seconds.toString(),
                            colorIndex: random.nextInt(6).toString()),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
