// import 'package:collection/collection.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:rxdart/subjects.dart';
// import 'package:starfish/bloc/action_bloc.dart';
// import 'package:starfish/bloc/group_bloc.dart';
// import 'package:starfish/bloc/material_bloc.dart';
// import 'package:starfish/bloc/results_bloc.dart';
// import 'package:starfish/bloc/deprecated_user_bloc.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_last_sync_date_time.dart';
// import 'package:starfish/utils/date_time_utils.dart';

// class DataBloc {
//   late MaterialBloc _materialBloc;
//   late GroupBloc _groupBloc;
//   late ActionBloc _actionBloc;
//   late ResultsBloc _resultsBloc;
//   late DeprecatedUserBloc _userBloc;

//   BehaviorSubject<String> _lastSyncTime = new BehaviorSubject<String>();

//   Stream<String> get lastSyncTime => _lastSyncTime.stream;

//   DataBloc() {
//     _materialBloc = MaterialBloc();
//     _groupBloc = GroupBloc();
//     _actionBloc = ActionBloc();
//     _resultsBloc = ResultsBloc();
//     _userBloc = DeprecatedUserBloc();

//     Box<HiveLastSyncDateTime> _lastSyncBox =
//         Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);

//     if (_lastSyncBox.values.firstOrNull != null) {
//       _lastSyncTime.sink.add(DateTimeUtils.formatDate(
//           _lastSyncBox.values.first.toDateTime(), "dd-MMM-yyyy HH:mm"));
//     } else {
//       _lastSyncTime.sink.add("");
//     }
//     _lastSyncBox.watch().listen((event) {
//       if (event.value == null) {
//       } else {
//         _lastSyncTime.sink.add(DateTimeUtils.formatDate(
//             (event.value as HiveLastSyncDateTime).toDateTime(),
//             "dd-MMM-yyyy HH:mm"));
//       }
//     });
//   }

//   MaterialBloc get materialBloc => _materialBloc;
//   GroupBloc get groupBloc => _groupBloc;
//   ActionBloc get actionBloc => _actionBloc;
//   ResultsBloc get resultsBloc => _resultsBloc;
//   DeprecatedUserBloc get userBloc => _userBloc;

//   void dispose() {
//     _lastSyncTime.close();
//   }
// }
