import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import 'package:todo/widgets/timer_widget.dart';
import '../providers/toggle_view_provider.dart';
import 'package:todo/constants/constant_colors.dart';

class TodoGridViewWidget extends StatelessWidget {
  final TodoProvider todoProvider;

  const TodoGridViewWidget({
    super.key,
    required this.todoProvider,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: todoProvider.list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              Provider.of<ToggleViewProvider>(context).crossAxisCount,
          childAspectRatio:
              Provider.of<ToggleViewProvider>(context).aspectRatio,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (BuildContext context, int index) {
        Duration startTime = Duration(
          minutes: int.parse(todoProvider.list[index].startMinute),
          seconds: int.parse(todoProvider.list[index].startSecond),
        );
        Duration currentTime = Duration(
          minutes: int.parse(todoProvider.list[index].minutes),
          seconds: int.parse(todoProvider.list[index].seconds),
        );
        return Container(
          decoration: BoxDecoration(
            color: ConstantColors
                .cardColors[int.parse(todoProvider.list[index].colorIndex)],
            borderRadius: BorderRadius.circular(5),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Center(
            child: ListTile(
              trailing: Icon(
                currentTime.inSeconds == startTime.inSeconds
                    ? Icons.pending
                    : currentTime.inSeconds == 0
                        ? Icons.done
                        : Icons.work_history,
                color: Colors.black,
                size: 30,
              ),
              title: Text(
                todoProvider.list[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              subtitle: TimerWidget(
                index: index,
                todo: todoProvider.list[index],
                minutes: int.parse(todoProvider.list[index].minutes),
                seconds: int.parse(todoProvider.list[index].seconds),
              ),
            ),
          ),
        );
      },
    );
  }
}
