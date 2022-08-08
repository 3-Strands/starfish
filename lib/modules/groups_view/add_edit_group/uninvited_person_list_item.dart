import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/widgets/separator_line_widget.dart';

class UnInvitedPersonListItem extends StatefulWidget {
  final HiveUser personName;
  final Function(HiveUser) onRemove;

  UnInvitedPersonListItem({
    Key? key,
    required this.personName,
    required this.onRemove,
  }) : super(key: key);

  _UnInvitedPersonListItemState createState() =>
      _UnInvitedPersonListItemState();
}

class _UnInvitedPersonListItemState extends State<UnInvitedPersonListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
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
                  widget.personName.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 21.5.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF434141),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    widget.onRemove(widget.personName);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.selectedButtonBG,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const SeparatorLine(),
          ],
        ),
      ),
    );
  }
}
