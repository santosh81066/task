import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<int> counts = List.generate(100, (index) => 0);
  int firstItemClickCount = 0;

  void resetCount(int index) {
    setState(() {
      counts[index] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: counts.length,
        itemBuilder: (context, index) {
          return VisibilityDetector(
            key: Key('item-$index'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction == 0) {
                resetCount(index);
              }
            },
            child: ListItemWidget(
              count: counts[index],
              onIncrement: () {
                if (index == 0) {
                  firstItemClickCount++;
                  if (firstItemClickCount == 3) {
                    setState(() {
                      counts[index]++;
                      firstItemClickCount = 0;
                    });
                  }
                } else {
                  setState(() {
                    counts[index]++;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;

  const ListItemWidget({
    Key? key,
    required this.count,
    required this.onIncrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onIncrement,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Text(count.toString()),
            MaterialButton(
              onPressed: onIncrement,
              child: const Text("+"),
            )
          ],
        ),
      ),
    );
  }
}
