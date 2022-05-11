import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview(this.file, {Key? key}) : super(key: key);
  final file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.pop(context),
        child: Hero(tag: file, child: Center(child: Image.file(file))),
      ),
    );
  }
}
