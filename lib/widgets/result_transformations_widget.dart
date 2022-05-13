import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/image_preview.dart';
import 'package:starfish/wrappers/file_system.dart';

class ResultTransformationsWidget extends StatefulWidget {
  HiveGroupUser groupUser;
  HiveDate month;
  HiveTransformation? hiveTransformation;
  Function(String, List<File>) onChange;

  ResultTransformationsWidget({
    Key? key,
    required this.groupUser,
    required this.month,
    this.hiveTransformation,
    required this.onChange,
  }) : super(key: key);

  @override
  State<ResultTransformationsWidget> createState() =>
      _ResultTransformationsWidgetState();
}

class _ResultTransformationsWidgetState
    extends State<ResultTransformationsWidget> {
  TextEditingController _transformationController = TextEditingController();
  List<File> _selectedFiles = [];
  bool _isEditMode = false;

  

  // @override
  // void initState() {
  //   super.initState();

  //   // _hiveTransformation =
  //   //     widget.groupUser.getTransformationForMonth(widget.month);
  //   if (widget.hiveTransformation != null &&
  //       widget.hiveTransformation!.impactStory != null) {
  //     _isEditMode = true;

  //     _transformationController.text = widget.hiveTransformation!.impactStory!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.hiveTransformation != null &&
        widget.hiveTransformation!.impactStory != null) {
      _isEditMode = true;

      _transformationController.text = widget.hiveTransformation!.impactStory!;
    } else {
      _transformationController.text = "";
    }

    return Card(
      color: Color(0xE6EFEFEF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsPath.resultsActiveIcon,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '${AppLocalizations.of(context)!.transformations}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(
                  color: Color(0xFF979797),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: FocusableTextField(
                controller: _transformationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText:
                      '${AppLocalizations.of(context)!.hintTextTransformationsTextField}',
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onFocusChange: (isFocused) {
                  if (isFocused) {
                    return;
                  }
                },
                onChange: (String value) {
                  widget.onChange(value, _selectedFiles);
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            //  if (_isEditMode) _previewFiles(widget.material!),
            // SizedBox(height: 10.h),

            // _previewSelectedFiles(),

            // Add Materials

            if (_selectedFiles.isNotEmpty ||
                (widget.hiveTransformation != null &&
                    widget.hiveTransformation!.localFiles.isNotEmpty))
              _previewSelectedFiles(),
            SizedBox(height: 10.h),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(30.r),
              color: Color(0xFF3475F0),
              child: Container(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if ((!_isEditMode && _selectedFiles.length >= 5) ||
                          (_isEditMode &&
                              (_selectedFiles.length +
                                      (widget.hiveTransformation!.localFiles
                                          .length)) >=
                                  5)) {
                        Fluttertoast.showToast(
                            msg:
                                AppLocalizations.of(context)!.maxFilesSelected);
                      } else {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.image,
                          //  allowedExtensions: ['jpg', 'png', 'jpeg'],
                        );

                        if (result != null) {
                          // if single selected file is IMAGE, open image in Cropper

                          if (result.count == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageCropperScreen(
                                    sourceImage: File(result.paths.first!),
                                    onDone: (File? _newFile) {
                                      if (_newFile == null) {
                                        return;
                                      }
                                      var fileSize = _newFile
                                          .readAsBytesSync()
                                          .lengthInBytes;
                                      if (fileSize > 5 * 1024 * 1024) {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .imageSizeValidation);
                                      } else {
                                        setState(() {
                                          _selectedFiles.add(_newFile);
                                        });
                                        widget.onChange(
                                            _transformationController.text,
                                            _selectedFiles);
                                      }
                                    }),
                              ),
                            ).then((value) => {
                                  // Handle cropped image here
                                });
                          } else {
                            setState(() {
                              _selectedFiles.addAll(result.paths
                                  .map((path) => File(path!))
                                  .toList());
                            });
                          }
                        } else {
                          // User canceled the picker
                        }
                      }
                    },
                    child: Text(
                      '${AppLocalizations.of(context)!.addPhotos}',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 17.sp,
                        color: Color(0xFF3475F0),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  )),
            ),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview({required File file, required Function onDelete}) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10.0, right: 10.0),
          child: Container(
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImagePreview(file))),
              child: Hero(
                tag: file,
                child: Card(
                  margin: const EdgeInsets.only(top: 12.0, right: 12.0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: file.getImagePreview(
                      fit: BoxFit.scaleDown,
                      //  height: 130.h,
                    ),
                  ),
                ),
                flightShuttleBuilder: (flightContext, animation, direction,
                    fromContext, toContext) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // setState(() {
            //   _selectedFiles.remove(file);
            // });
            onDelete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _previewSelectedFiles() {
    final List<Widget> _widgetList = [];

    for (File file in _selectedFiles) {
      _widgetList.add(_imagePreview(
          file: file,
          onDelete: () {
            setState(() {
              _selectedFiles.remove(file);
            });
          }));
    }

    if (widget.hiveTransformation != null &&
        widget.hiveTransformation!.localFiles.isNotEmpty) {
      for (HiveFile _hiveFile in widget.hiveTransformation!.localFiles) {
        File file = File(_hiveFile.filepath!);
        _widgetList.add(_imagePreview(
            file: file,
            onDelete: () {
              setState(() {
                _hiveFile.delete();
              });
            }));
      }
    }

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: (_selectedFiles.length == 1 &&
                  widget.hiveTransformation!.localFiles.length == 0) ||
              (widget.hiveTransformation!.localFiles.length == 1 &&
                  _selectedFiles.length == 0)
          ? 1
          : 2,
      childAspectRatio: 1,
      children: _widgetList,
    );
  }
}
