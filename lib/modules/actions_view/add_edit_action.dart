import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/enums/action_type.dart';
import 'package:starfish/modules/settings_view/settings_view.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddEditAction extends StatefulWidget {
  const AddEditAction({Key? key}) : super(key: key);

  @override
  _AddEditActionState createState() => _AddEditActionState();
}

class _AddEditActionState extends State<AddEditAction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isEditMode = false;
  final _addActionController = TextEditingController();
  final _descriptionController = TextEditingController();
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  Action_Type _actionType = Action_Type.TEXT_INSTRUCTION;
  late String _setDate = 'Select due date';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
       _setDate = DateFormat.yMd().format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.actionScreenBG,
      appBar: AppBar(
        backgroundColor: AppColors.actionScreenBG,
        automaticallyImplyLeading: false,
        title: Container(
          height: 64.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppLogo(hight: 36.h, width: 37.w),
              Text(
                _isEditMode ? Strings.editActionText : Strings.addActionText,
                style: dashboardNavigationTitle,
              ),
              IconButton(
                icon: SvgPicture.asset(AssetsPath.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.reuseActionText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.selectActions).then(
                          (value) => FocusScope.of(context).requestFocus(
                            new FocusNode(),
                          ),
                        );
                  },
                  child: Container(
                    height: 52.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Select an action',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Color(0xFF434141)),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF434141),
                              size: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Name of the Action',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                TextFormField(
                  controller: _addActionController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtFieldBackground,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Type of Action',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: AppColors.txtFieldBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<Action_Type>(
                          isExpanded: true,
                          iconSize: 35,
                          style: TextStyle(
                            color: Color(0xFF434141),
                            fontSize: 16.sp,
                            fontFamily: 'OpenSans',
                          ),
                          hint: Text(
                            _actionType.about,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xFF434141),
                              fontSize: 16.sp,
                              fontFamily: 'OpenSans',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onChanged: (Action_Type? value) {
                            setState(() {
                              _actionType = value!;
                            });
                          },
                          items: Action_Type.values
                              .map<DropdownMenuItem<Action_Type>>(
                                  (Action_Type value) {
                            return DropdownMenuItem<Action_Type>(
                              value: value,
                              child: Text(
                                value.about,
                                style: TextStyle(
                                  color: Color(0xFF434141),
                                  fontSize: 14.sp,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Description
                Text(
                  'Instructions',
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 13.h),
                Container(
                  child: TextFormField(
                    maxLines: 4,
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Topic Selection
                Text(
                  'Assign this Action to',
                  textAlign: TextAlign.left,
                  style: titleTextStyle,
                ),
                SizedBox(height: 13.h),
                /* Container(
                  height: 52.h,
                  width: 345.w,
                  decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Select option(s)',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.sp, color: Color(0xFF434141)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF434141),
                            size: 20.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/

                Container(
                  //height: 54.h,
                  decoration: BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  width: MediaQuery.of(context).size.width,
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: GFMultiSelect(
                      //hideDropdownUnderline: true,
                      items: [
                        "Me",
                        "Group Name 1",
                        "Group Name 2",
                        "Group Name 3"
                      ],
                      onSelect: (value) {
                        print('selected $value ');
                      },
                      dropdownTitleTileText: 'Select option(s)',
                      dropdownTitleTileColor: Color(0xFFEFEFEF),
                      dropdownTitleTileMargin: EdgeInsets.only(
                          top: 2.sp, left: 10.sp, right: 5.sp, bottom: 2.sp),
                      dropdownTitleTilePadding: EdgeInsets.all(10),
                      dropdownUnderlineBorder:
                          const BorderSide(color: Colors.transparent, width: 0),
                      dropdownTitleTileBorder:
                          Border.all(color: Colors.transparent, width: 0),
                      dropdownTitleTileBorderRadius: BorderRadius.circular(5),
                      expandedIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                      collapsedIcon: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black54,
                      ),
                      submitButton: Text('OK'),
                      dropdownTitleTileTextStyle:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                      type: GFCheckboxType.circle,
                      activeBgColor: Colors.green.withOpacity(0.5),
                      inactiveBorderColor: Colors.grey[200]!,
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(6),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Text(
                  'Due date',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF434141)),
                ),
                SizedBox(height: 13.h),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    height: 52.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              _setDate,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Color(0xFF434141)),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF434141),
                              size: 20.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
        color: AppColors.txtFieldBackground,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(Strings.cancel),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  _isEditMode ? Strings.update : Strings.create,
                ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.selectedButtonBG,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
