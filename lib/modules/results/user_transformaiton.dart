import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/results/cubit/add_edit_transformation_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/image_preview.dart';
import 'package:starfish/wrappers/file_system.dart';

class UserTransformation extends StatelessWidget {
  const UserTransformation({
    Key? key,
    required this.groupUser,
    required this.month,
    this.transformation,
  }) : super(key: key);

  final GroupUser groupUser;
  final Date month;
  final Transformation? transformation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('${groupUser.id}:${month.year}-${month.month}'),
      create: (context) => AddEditTransformaitonCubit(
        dataRepository: context.read<DataRepository>(),
        groupUser: groupUser,
        month: month,
        transformation: transformation,
      ),
      child: UserTransformationView(),
    );
  }
}

class UserTransformationView extends StatelessWidget {
  const UserTransformationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                  '${appLocalizations.transformations}',
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
              child: BlocBuilder<AddEditTransformaitonCubit,
                  AddEditTransformationState>(
                builder: (context, state) {
                  return FocusableTextField(
                    //controller: _transformationController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText:
                          '${appLocalizations.hintTextTransformationsTextField}',
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 16.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    text: state.impactStory,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    onFocusChange: (isFocused) {
                      if (isFocused) {
                        return;
                      }
                      context
                          .read<AddEditTransformaitonCubit>()
                          .saveImpactStory();
                    },
                    onChange: (String value) {
                      context
                          .read<AddEditTransformaitonCubit>()
                          .updateImpactStory(value);
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<AddEditTransformaitonCubit, AddEditTransformationState>(
                buildWhen: (previous, current) =>
                    previous.previouslySelectedFiles !=
                        current.previouslySelectedFiles ||
                    previous.newlySelectedFiles != current.newlySelectedFiles,
                builder: (context, state) {
                  return _previewSelectedFiles(context,
                      state.previouslySelectedFiles, state.newlySelectedFiles);
                }),
            SizedBox(height: 10.h),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(30.r),
              color: Color(0xFF3475F0),
              child: Container(
                width: double.infinity,
                height: 50.h,
                child: BlocBuilder<AddEditTransformaitonCubit,
                    AddEditTransformationState>(
                  buildWhen: (previous, current) =>
                      previous.previouslySelectedFiles !=
                          current.previouslySelectedFiles ||
                      previous.newlySelectedFiles != current.newlySelectedFiles,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (state.previouslySelectedFiles.length +
                                state.newlySelectedFiles.length >=
                            5) {
                          Fluttertoast.showToast(
                              msg: appLocalizations.maxFilesSelected);
                        } else {
                          final result = await getPickerFileWithCrop(
                            context,
                            type: FileType.image,
                          );

                          if (result != null) {
                            // if single selected file is IMAGE, open image in Cropper

                            var fileSize = result.size;
                            if (fileSize > 5 * 1024 * 1024) {
                              Fluttertoast.showToast(
                                  msg: appLocalizations.imageSizeValidation);
                            } else {
                              context
                                  .read<AddEditTransformaitonCubit>()
                                  .addFile(result);
                            }
                          } else {
                            // User canceled the picker
                          }
                        }
                      },
                      child: Text(
                        '${appLocalizations.addPhotos}',
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
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewSelectedFiles(
      BuildContext context,
      List<FileReference> previouslySelectedFiles,
      List<File> newlySelectedFiles) {
    final List<Widget> _widgetList = [];

    for (final file in newlySelectedFiles) {
      _widgetList.add(_imagePreview(
          context: context,
          file: File(file.path),
          onDelete: () {
            // setState(() {
            //   _selectedFiles.remove(file);
            // });
            context.read<AddEditTransformaitonCubit>().removeFile(file);
          }));
    }

    if (previouslySelectedFiles.isNotEmpty) {
      for (FileReference fileReference in previouslySelectedFiles) {
        File file = File(fileReference.filepath!);
        _widgetList.add(_imagePreview(
            context: context,
            file: file,
            onDelete: () {
              // setState(() {
              //   _hiveFile.delete();
              // });
            }));
      }
    }

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: _widgetList.length == 1 ? 1 : 2,
      childAspectRatio: 1,
      children: _widgetList,
    );
  }

  Widget _imagePreview(
      {required BuildContext context,
      required File file,
      required Function onDelete}) {
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
}
