part of 'dashboard_navigation_cubit.dart';

@immutable
abstract class DashboardNavigationTab {
  const DashboardNavigationTab();

  int get index;

  static const tabs = [
    MaterialsTab(),
    GroupsTab(),
    ActionsTab(),
    ResultsTab(),
  ];
}

class MaterialsTab extends DashboardNavigationTab {
  const MaterialsTab();

  final index = 0;
}

class GroupsTab extends DashboardNavigationTab {
  const GroupsTab();

  final index = 1;
}

class ActionsTab extends DashboardNavigationTab {
  const ActionsTab([this.currentTab]);

  final grpc.ActionTab? currentTab;
  final index = 2;
}

class ResultsTab extends DashboardNavigationTab {
  const ResultsTab([this.currentTab]);

  final grpc.ResultsTab? currentTab;
  final index = 3;
}
