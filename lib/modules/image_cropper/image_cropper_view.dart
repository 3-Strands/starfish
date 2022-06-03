import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:starfish/wrappers/file_system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/wrappers/platform.dart';

String _getMimeType(String file) {
  final index = file.lastIndexOf('.');
  return index == -1 ? '' : file.substring(index + 1);
}

Future<PlatformFile?> getPickerFileWithCrop(BuildContext context, {
  FileType type = FileType.any,
  List<String>? allowedExtensions,
}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    withReadStream: true,
    type: type,
    allowedExtensions: allowedExtensions,
  );
  PlatformFile? file = result?.files.single;
  if (file != null && (
    type == FileType.image ||
    ['jpg', 'jpeg', 'png'].contains(_getMimeType(file.name))
  )) {
    return Navigator.push<PlatformFile>(
      context,
      MaterialPageRoute(
        builder: (context) => ImageCropperScreen(
          sourceImage: file,
          onDone: (PlatformFile newFile) {
            Navigator.pop(context, newFile);
          },
        ),
      ),
    );
  }
  return file;
}

class ImageCropperScreen extends StatefulWidget {
  final PlatformFile sourceImage;
  final void Function(PlatformFile) onDone;

  ImageCropperScreen({
    Key? key,
    required this.sourceImage,
    required this.onDone,
  }) : super(key: key);

  @override
  _ImageCropperScreenState createState() => _ImageCropperScreenState();
}

class _ImageCropperScreenState extends State<ImageCropperScreen> {
  /*static const _images = const [
    'assets/images/city.png',
    'assets/images/lake.png',
    'assets/images/train.png',
    'assets/images/turtois.png',
  ];*/

  final _cropController = CropController();
  //final _imageDataList = <Uint8List>[];
  Uint8List? _imageData;
  bool _loadingImage = false;
  /*var _currentImage = 0;
  set currentImage(int value) {
    setState(() {
      _currentImage = value;
    });
    _cropController.image = _imageData!;
  }*/

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  void initState() {
    _load(widget.sourceImage);
    super.initState();
  }

  Future<void> _load(PlatformFile source) async {
    //final assetData = await rootBundle.load(assetName);
    //return assetData.buffer.asUint8List();
    setState(() {
      _loadingImage = true;
    });
    final buffer = <int>[];
    await for (final chunk in source.readStream!) {
      buffer.addAll(chunk);
    }
    _imageData = Uint8List.fromList(buffer);
    setState(() {
      _loadingImage = false;
    });
  }

  /*Future<void> _loadAllImages() async {
    setState(() {
      _isLoaded = true;
    });
    for (final assetName in _images) {
      _imageDataList.add(await _load(assetName));
    }
    setState(() {
      _isLoaded = false;
    });
  }*/

  Future<void> _saveCroppedFile(Uint8List croppedData) async {
    final sourceFileName = widget.sourceImage.name;
    String _targetFileName = sourceFileName.replaceFirstMapped(
        sourceFileName.split(".").first,
        (match) =>
            '${sourceFileName.split(".").first}_${DateTime.now().millisecondsSinceEpoch}');

    final sourceFilePath = Platform.isWeb ? null : widget.sourceImage.path;
    final _destinationPath = sourceFilePath?.replaceFirstMapped(
        sourceFileName, (match) => _targetFileName);
    if (_destinationPath != null) {

      File _targetFile = File(_destinationPath);
      
      await _targetFile.createWithContent(croppedData.toList());
    }

    widget.onDone(PlatformFile(
      path: _destinationPath,
      name: _targetFileName,
      size: croppedData.lengthInBytes,
      bytes: croppedData,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${AppLocalizations.of(context)!.imageCropperScreenTitle}"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Visibility(
            visible: !_loadingImage && !_isCropping,
            child: Column(
              children: [
                Expanded(
                  child: Visibility(
                    visible: _croppedData == null,
                    child: Stack(
                      children: [
                        Crop(
                          controller: _cropController,
                          image: _imageData ?? Uint8List(0),
                          onCropped: (croppedData) {
                            _saveCroppedFile(croppedData);
                            setState(() {
                              _croppedData = croppedData;
                              _isCropping = false;
                            });
                          },
                          withCircleUi: _isCircleUi,
                          onStatusChanged: (status) => setState(() {
                            _statusText = <CropStatus, String>{
                                  CropStatus.nothing: 'Crop has no image data',
                                  CropStatus.loading:
                                      'Crop is now loading given image',
                                  CropStatus.ready: 'Crop is now ready!',
                                  CropStatus.cropping:
                                      'Crop is now cropping image',
                                }[status] ??
                                '';
                          }),
                          initialSize: 0.5,
                          maskColor: _isSumbnail ? Colors.white : null,
                          cornerDotBuilder: (size, edgeAlignment) => _isSumbnail
                              ? const SizedBox.shrink()
                              : const DotControl(),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: GestureDetector(
                            onTapDown: (_) =>
                                setState(() => _isSumbnail = true),
                            onTapUp: (_) => setState(() => _isSumbnail = false),
                            child: CircleAvatar(
                              backgroundColor: _isSumbnail
                                  ? Colors.blue.shade50
                                  : Colors.blue,
                              child: Center(
                                child: Icon(Icons.crop_free_rounded),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    replacement: Center(
                      child: _croppedData == null
                          ? SizedBox.shrink()
                          : Image.memory(_croppedData!),
                    ),
                  ),
                ),
                if (_croppedData == null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.crop_7_5),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 16 / 4;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_16_9),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 16 / 9;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_5_4),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 4 / 3;
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.crop_square),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController
                                  ..withCircleUi = false
                                  ..aspectRatio = 1;
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.circle_outlined),
                                onPressed: () {
                                  _isCircleUi = true;
                                  _cropController.withCircleUi = true;
                                }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isCropping = true;
                              });
                              _isCircleUi
                                  ? _cropController.cropCircle()
                                  : _cropController.crop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                  "${AppLocalizations.of(context)!.imageCropDoneButton}"),
                            ),
                          ),
                        ),
                        //const SizedBox(height: 40),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                /*Text(_statusText),
                const SizedBox(height: 16),*/
              ],
            ),
            replacement: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
