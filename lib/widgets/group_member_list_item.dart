import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/app_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/widgets/seprator_line_widget.dart';

class GroupMemberListItem extends StatefulWidget {
  final HiveGroupUser groupUser;

  GroupMemberListItem({
    Key? key,
    required this.groupUser,
  }) : super(key: key);

  _GroupMemberListItemState createState() => _GroupMemberListItemState();
}

class _GroupMemberListItemState extends State<GroupMemberListItem> {
  late AppBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of(context);
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.groupUser.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF434141),
                ),
              ),
              PopupMenuButton(
                color: Colors.white,
                elevation: 20,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Text(
                  '${GroupUser_Role.valueOf(widget.groupUser.role!)!.name}',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16.sp,
                    color: Color(0xFF3475F0),
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      Strings.makeAdmin,
                      style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text(
                      Strings.makeTeacher,
                      style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text(
                      Strings.makeRemove,
                      style: TextStyle(
                          color: Color(0xFF3475F0),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    value: 2,
                  ),
                ],
                onSelected: (int value) {
                  switch (value) {
                    case 0:
                      widget.groupUser.role = GroupUser_Role.ADMIN.value;
                      widget.groupUser.isUpdated = true;
                      break;
                    case 1:
                      widget.groupUser.role = GroupUser_Role.TEACHER.value;
                      widget.groupUser.isUpdated = true;
                      break;
                    case 2:
                      widget.groupUser.isDirty = true;
                      break;
                    default:
                  }
                  bloc.groupBloc.createUpdateGroupUser(widget.groupUser);
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            widget.groupUser.phone,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18.sp,
              color: Color(0xFF434141),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SepratorLine(
            hight: 1.h,
            edgeInsets: EdgeInsets.only(left: 0.w, right: 0.w),
          ),
        ],
      ),
    );
  }
}
