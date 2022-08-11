import 'package:bloc/bloc.dart';

part 'group_navigation_state.dart';

class GroupNavigationCubit extends Cubit<GroupNavigationState> {
  GroupNavigationCubit() : super(GroupNavigationState.mainEdit);

  void navigated(GroupNavigationState navigation) {
    emit(navigation);
  }
}
