import 'package:flutter/material.dart';
import 'package:starfish/bloc/action_bloc.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectMaterial extends StatefulWidget {
  SelectMaterial({Key? key, required this.onSelect}) : super(key: key);

  final Function(HiveMaterial) onSelect;

  @override
  _SelectMaterialState createState() => _SelectMaterialState();
}

class _SelectMaterialState extends State<SelectMaterial>
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
    bloc.actionBloc.fetchMaterials();
    return new Scaffold(
      appBar: new AppBar(
        title: Text(AppLocalizations.of(context)!.selectAMaterial),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                initialValue: bloc.actionBloc.materialQuery,
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
              stream: bloc.actionBloc.materials,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HiveMaterial>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      HiveMaterial material = snapshot.data!.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            widget.onSelect(material);
                            Navigator.pop(context);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    material.title!,
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onSearchTextChanged(ActionBloc bloc, String text) async {
    bloc.materialQuery = text;
    bloc.fetchMaterials();

    setState(() {});
  }
}
