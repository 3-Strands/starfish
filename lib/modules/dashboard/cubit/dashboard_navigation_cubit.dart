import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/src/grpc_extensions.dart' as grpc;

part 'dashboard_navigation_state.dart';

class DashboardNavigationCubit extends Cubit<DashboardNavigationTab> {
  DashboardNavigationCubit({DashboardNavigationTab? initialTab})
      : super(initialTab ?? const GroupsTab());

  void navigationRequested(DashboardNavigationTab tab) => emit(tab);
}
