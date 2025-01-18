import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';

class DragDropFile extends StatefulWidget {
  final ValueChanged<DroppedFile> onDroppeedFile;

  const DragDropFile({
    super.key,
    required this.onDroppeedFile,
  });

  @override
  State<DragDropFile> createState() => _DragDropFileState();
}

class _DragDropFileState extends State<DragDropFile> {
  late DropzoneViewController controller;
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final colorBackground = isHighlighted ? Colors.blue : Colors.green;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: colorBackground,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.white,
          strokeWidth: 3,
          dashPattern: const [8,4],
          padding: EdgeInsets.zero,
          radius: const Radius.circular(10),
          child: Stack(
            children: [
              DropzoneView(
                onDropFile: acceptFile,
                onHover: () => setState(() {
                  isHighlighted = true;
                }),
                onLeave: () => setState(() {
                  isHighlighted = false;
                }),
                onCreated: (controller) => this.controller = controller,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload,
                      size: 80,
                      color: Colors.white,
                    ),
                    const Text(
                      'Drop Files here',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        ),
                        onPressed: () async {
                          final event = await controller.pickFiles();
                          if (event.isEmpty) return;
                          acceptFile(event.first);
                        },
                        label: const Text(
                          'Choose Photo',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    final droppedFile =
        DroppedFile(url: url, name: name, mime: mime, bytes: bytes);
    widget.onDroppeedFile(droppedFile);
    setState(() {
      isHighlighted = false;
    });
  }
}
