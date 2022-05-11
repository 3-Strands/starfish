import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:starfish/wrappers/file_system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageCropperScreen extends StatefulWidget {
  final File? sourceImage;
  final Function(File?) onDone;

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

  var _loadingImage = false;
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
    //_loadAllImages();
    if (widget.sourceImage != null) {
      _load(widget.sourceImage!);
    }
    super.initState();
  }

  /*Future<void> _loadAllImages() async {
    setState(() {
      _loadingImage = true;
    });
    for (final assetName in _images) {
      _imageDataList.add(await _load(assetName));
    }
    setState(() {
      _loadingImage = false;
    });
  }*/

  Future<void> _load(File _sourceImage) async {
    //final assetData = await rootBundle.load(assetName);
    //return assetData.buffer.asUint8List();
    setState(() {
      _loadingImage = true;
    });
    _imageData = await _sourceImage.readAsBytes();
    setState(() {
      _loadingImage = false;
    });
  }

  Future<void> _saveCroppedFile(
      String sourceFilePath, Uint8List croppedData) async {
    String _filename = sourceFilePath.split("/").last;
    String _targetFileName = _filename.replaceFirstMapped(
        _filename.split(".").first,
        (match) =>
            '${_filename.split(".").first}_${DateTime.now().millisecondsSinceEpoch}');

    String _destinationPath = sourceFilePath.replaceFirstMapped(
        _filename, (match) => _targetFileName);

    File _targetFile = File(_destinationPath);
    
    await _targetFile.createWithContent(croppedData.toList());

    widget.onDone(_targetFile);
    Navigator.pop(context);
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
                          image: _imageData!,
                          onCropped: (croppedData) {
                            _saveCroppedFile(
                                widget.sourceImage!.path, croppedData);
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
