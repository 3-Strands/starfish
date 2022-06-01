import 'package:flutter/material.dart';
import 'package:starfish/wrappers/file_system.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview(this.file, {Key? key}) : super(key: key);
  final File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.pop(context),
        child: Hero(tag: file, child: Center(child: file.getImagePreview())),
      ),
    );
  }
}
