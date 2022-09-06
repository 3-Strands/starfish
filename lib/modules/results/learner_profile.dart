import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/modules/results/cubit/learner_profile_cubit.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/widgets/focusable_text_field.dart';

class LearnerProfile extends StatelessWidget {
  const LearnerProfile({
    Key? key,
    required this.groupUser,
    required this.month,
  }) : super(key: key);

  final GroupUser groupUser;
  final Date month;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey('${groupUser.id}:${month.year}-${month.month}'),
      create: (context) => LearnerProfileCubit(
        dataRepository: context.read<DataRepository>(),
        groupUser: groupUser,
      ),
      child: LearnerProfileView(),
    );
  }
}

class LearnerProfileView extends StatelessWidget {
  const LearnerProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(
          "${appLocalizations.learnerProfile}",
          style: TextStyle(
              fontSize: 17.sp,
              fontFamily: "OpenSans",
              color: Color(0xFF4F4F4F),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5.h,
        ),
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
          child: BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
            builder: (context, state) {
              return FocusableTextField(
                maxCharacters: 500,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                initialValue: state.profile,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {
                  context.read<LearnerProfileCubit>().saveProfile();
                },
                onChange: (String value) {
                  context.read<LearnerProfileCubit>().updateProfile(value);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
