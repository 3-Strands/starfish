part of 'learner_profile_cubit.dart';

@immutable
class LearnerProfileState {
  const LearnerProfileState({
    required this.groupUser,
    required this.profile,
  });

  final GroupUser groupUser;
  final String profile;

  LearnerProfileState copyWith({
    GroupUser? groupUser,
    Date? month,
    String? profile,
  }) =>
      LearnerProfileState(
        groupUser: groupUser ?? this.groupUser,
        profile: profile ?? this.profile,
      );
}
