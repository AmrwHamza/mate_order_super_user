import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/drag_drop_file.dart';
import 'package:mate_order_super_user/Features/Home/presentation/view/widgets/dropped_file_widget.dart';

class DragView extends StatefulWidget {
  const DragView({super.key});

  @override
  State<DragView> createState() => _DragViewState();
}

class _DragViewState extends State<DragView> {
  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DroppedFileWidget(file: file),
              const SizedBox(height: 16),
              Container(
                height: 300,
                child: DragDropFile(
                  onDroppeedFile: (file) => setState(() {
                    this.file = file;
                  }),
                ),
              ),
            ],
          )),
    );
  }
}
