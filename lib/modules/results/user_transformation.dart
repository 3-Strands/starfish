import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/modules/image_cropper/image_cropper_view.dart';
import 'package:starfish/modules/results/cubit/add_edit_transformation_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';
import 'package:starfish/widgets/image_preview.dart';
import 'package:starfish/wrappers/file_system.dart';

class UserTransformation extends StatelessWidget {
  const UserTransformation({
    super.key,
    required this.groupId,
    required this.userId,
    required this.month,
    this.transformation,
  });

  final String groupId;
  final String userId;
  final Date month;
  final Transformation? transformation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('$groupId:$userId:${month.year}-${month.month}'),
      create: (context) => AddEditTransformationCubit(
        dataRepository: context.read<DataRepository>(),
        groupId: groupId,
        userId: userId,
        month: month,
        transformation: transformation,
      ),
      child: UserTransformationView(
        initialImpactStory: transformation?.impactStory ?? '',
      ),
    );
  }
}

class UserTransformationView extends StatelessWidget {
  const UserTransformationView({
    super.key,
    required this.initialImpactStory,
  });

  final String initialImpactStory;

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
                  appLocalizations.transformations,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19.sp,
                    fontFamily: "OpenSans",
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            FocusableTextField(
              //controller: _transformationController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: appLocalizations.hintTextTransformationsTextField,
                hintStyle: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 16.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              initialValue: initialImpactStory,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) {
                context
                    .read<AddEditTransformationCubit>()
                    .impactStoryChanged(value);
              },
            ),
            SizedBox(height: 10.h),
            const _PreviewImages(),
            SizedBox(height: 10.h),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(30.r),
              color: Color(0xFF3475F0),
              child: Container(
                width: double.infinity,
                height: 50.h,
                child: BlocBuilder<AddEditTransformationCubit,
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
                                  .read<AddEditTransformationCubit>()
                                  .fileAdded(result);
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
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _PreviewImages extends StatelessWidget {
  const _PreviewImages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditTransformationCubit, AddEditTransformationState>(
        buildWhen: (previous, current) =>
            previous.previouslySelectedFiles !=
                current.previouslySelectedFiles ||
            previous.newlySelectedFiles != current.newlySelectedFiles,
        builder: (context, state) {
          if (state.previouslySelectedFiles.length +
                  state.newlySelectedFiles.length ==
              0) {
            return const SizedBox();
          }
          final List<Widget> widgetList = [
            ...state.newlySelectedFiles.map(
              (file) => _ImagePreview(file: file),
            ),
            ...state.previouslySelectedFiles.map(
              (fileReference) =>
                  _ImagePreview(file: File(fileReference.filepath!)),
            ),
          ];

          return GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: widgetList.length == 1 ? 1 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
            children: widgetList,
          );
        });
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    super.key,
    required this.file,
    this.isDeletable = false,
  });

  final File file;
  final bool isDeletable;

  static final borderRadius = BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    Widget widget = Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // borderRadius: borderRadius,
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ImagePreview(file))),
        child: Hero(
          tag: file,
          child: file.getImagePreview(
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
    if (isDeletable) {
      widget = Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          widget,
          IconButton(
            onPressed: () {
              context.read<AddEditTransformationCubit>().fileRemoved(file);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      );
    }
    return widget;
  }
}
