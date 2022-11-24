// ignore_for_file: library_private_types_in_public_api, must_be_immutable, use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/database/todo_database.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/constants/constant_colors.dart';

class TimerWidget extends StatefulWidget {
  final TodoModel todo;
  final int index;
  int minutes;
  int seconds;
  TimerWidget({
    Key? key,
    required this.minutes,
    required this.seconds,
    required this.todo,
    required this.index,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late String time;
  late Duration countdownDuration =
      Duration(minutes: widget.minutes, seconds: widget.seconds);
  Duration duration = const Duration();
  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void reset() {
    if (mounted) {
      if (countDown) {
        setState(() => duration = countdownDuration);
      } else {
        setState(() => duration = const Duration());
      }
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeconds;
        if (seconds < 0) {
          TodoDatabase.updateTodoDuration(
            id: widget.todo.id,
            todo: TodoModel(
              id: widget.todo.id,
              minutes: 0.toString(),
              seconds: 0.toString(),
              title: widget.todo.title,
              colorIndex: widget.todo.colorIndex,
              startMinute: widget.todo.startMinute.toString(),
              startSecond: widget.todo.startSecond.toString(),
            ),
          );
          Provider.of<TodoProvider>(context, listen: false).updateListItem(
            widget.index,
            TodoModel(
              id: widget.todo.id,
              title: widget.todo.title,
              colorIndex: widget.todo.colorIndex,
              minutes: 0.toString(),
              seconds: 0.toString(),
              startMinute: widget.todo.startMinute.toString(),
              startSecond: widget.todo.startSecond.toString(),
            ),
          );
          timer?.cancel();
        } else {
          duration = Duration(seconds: seconds);
        }
      });
    }
  }

  void stopTimer({bool resets = true}) {
    widget.minutes = duration.inMinutes.remainder(60);
    widget.seconds = duration.inSeconds.remainder(60);
    if (resets) {
      reset();
    }
    if (mounted) {
      setState(() => timer?.cancel());
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.todo.minutes == 0.toString()) &&
        (widget.todo.seconds == 0.toString())) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "Task Completed",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }
    return Row(
      children: <Widget>[
        buildTime(),
        const SizedBox(
          height: 80,
        ),
        buildButtons()
      ],
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      children: [
        buildTimeCard(time: minutes),
        const SizedBox(
          child: Text(
            ":",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ),
        buildTimeCard(time: seconds),
      ],
    );
  }

  Widget buildTimeCard({required String time}) {
    return Text(
      time,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: ConstantColors.timerColor,
        fontSize: 18,
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
    return isRunning || isCompleted
        ? ButtonWidget(
            icon: Icons.pause_circle,
            color: Colors.black87,
            onClicked: () {
              if (isRunning) {
                stopTimer(resets: false);
                TodoDatabase.updateTodoDuration(
                  id: widget.todo.id,
                  todo: TodoModel(
                    id: widget.todo.id,
                    title: widget.todo.title,
                    minutes: widget.minutes.toString(),
                    seconds: widget.seconds.toString(),
                    colorIndex: widget.todo.colorIndex,
                    startMinute: widget.todo.startMinute.toString(),
                    startSecond: widget.todo.startSecond.toString(),
                  ),
                );
                Provider.of<TodoProvider>(context, listen: false)
                    .updateListItem(
                  widget.index,
                  TodoModel(
                    id: widget.todo.id,
                    title: widget.todo.title,
                    colorIndex: widget.todo.colorIndex,
                    minutes: widget.minutes.toString(),
                    seconds: widget.seconds.toString(),
                    startMinute: widget.todo.startMinute.toString(),
                    startSecond: widget.todo.startSecond.toString(),
                  ),
                );
              }
            })
        : ButtonWidget(
            icon: Icons.play_circle,
            color: Colors.black87,
            onClicked: () {
              startTimer();
            },
          );
  }
}

class ButtonWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.color,
    required this.onClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClicked,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
