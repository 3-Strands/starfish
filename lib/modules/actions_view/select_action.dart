import 'package:flutter/material.dart';
import 'package:starfish/bloc/action_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/enums/action_type.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectActions extends StatefulWidget {
  SelectActions({Key? key, required this.onSelect}) : super(key: key);
  final Function(HiveAction) onSelect;

  @override
  _SelectActionsState createState() => _SelectActionsState();
}

class _SelectActionsState extends State<SelectActions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    bloc.actionBloc.fetchActions();
    return new Scaffold(
      appBar: new AppBar(
        title: Text(AppLocalizations.of(context)!.selectAction),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                initialValue: '',
                onValueChanged: (value) {
                  onSearchTextChanged(bloc.actionBloc, value);
                },
                onDone: (value) {
                  onSearchTextChanged(bloc.actionBloc, value);
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.actionBloc.actions,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HiveAction>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      HiveAction action = snapshot.data!.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            widget.onSelect(action);
                            Navigator.pop(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.name!,
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      AppLocalizations.of(context)!.type +
                                          ': ' +
                                          "${Action_Type.valueOf(action.type!)!.about}",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Color(0xFF797979))),
                                  Text(
                                      AppLocalizations.of(context)!.usedBy +
                                          ': ' +
                                          "${action.group != null ? action.group!.name : 'None'}",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Color(0xFF797979))),
                                  Text(
                                      AppLocalizations.of(context)!
                                              .createdDate +
                                          ': ' +
                                          "${_getCreatedDate(action)}",
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Color(0xFF797979))),
                                ],
                              ),
                            ),
                            margin: const EdgeInsets.all(0.0),
                            elevation: 2,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getCreatedDate(HiveAction action) {
    if (action.editHistory != null && action.editHistory!.length > 0) {
      var createdEvent =
          action.editHistory!.where((element) => element.event == 1).first;
      return DateTimeUtils.formatDate(createdEvent.time!, 'dd-MMM-yyyy');
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onSearchTextChanged(ActionBloc bloc, String text) async {
    bloc.reuseActionQuery = text;
    bloc.fetchActions();

    setState(() {});
  }
}
