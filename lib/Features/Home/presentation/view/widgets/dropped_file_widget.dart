import 'package:flutter/material.dart';
import 'package:mate_order_super_user/Features/Home/data/models/dropped_file.dart';

class DroppedFileWidget extends StatelessWidget {
  final DroppedFile? file;
  const DroppedFileWidget({super.key, this.file});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildImage(),
        if (file != null) buildFileDetails(file!),
      ],
    );
  }

  Widget buildImage() {
    if (file == null) return buildEmptyFile('NoFile');
    return Image.network(
      file!.url,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => buildEmptyFile('No Preview'),
    );
  }

  Widget buildEmptyFile(String s) => Container(
        width: 120,
        height: 120,
        color: Colors.blue.shade300,
        child: Center(
            child: Text(
          s,
          style: const TextStyle(
            color: Colors.white,
          ),
        )),
      );

  Widget buildFileDetails(DroppedFile droppedFile) {
    const style = TextStyle(fontSize: 20);

    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            file!.name,
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            file!.mime,
            style: style,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(file!.size)
        ],
      ),
    );
  }
}
