import 'package:flutter/material.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/models/select_action_response.dart';
import 'package:starfish/widgets/searchbar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectActions extends StatefulWidget {
  const SelectActions({Key? key}) : super(key: key);

  @override
  _SelectActionsState createState() => _SelectActionsState();
}

class _SelectActionsState extends State<SelectActions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController controller = new TextEditingController();
  List<ActionDetails> _searchResult = [];
  List<ActionDetails> _actionDetails = [];

  // Get json result and convert it to model. Then add
  Future<Null> _getActionDetails() async {
    // final response = await http.get(url);
    Map<String, dynamic> action1 = {
      "title": "Read the chronicles of Narnia",
      "type": "Type: Use and respond to a tool",
      "usedby": "Used by: GroupName1, GroupName2",
      "lastused": "Last used: May 15, 2021 Rating: 60%"
    };
    Map<String, dynamic> action2 = {
      "title": "Read the chronicles of Narnia2",
      "type": "Type: Use and respond to a tool2",
      "usedby": "Used by: GroupName1, GroupName2",
      "lastused": "Last used: May 15, 2021 Rating: 60%"
    };

    setState(() {
      _actionDetails.add(ActionDetails.fromJson(action1));
      _actionDetails.add(ActionDetails.fromJson(action2));
      _actionDetails.add(ActionDetails.fromJson(action2));
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _getActionDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select Action'),
        elevation: 0.0,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                initialValue: '',
                onValueChanged: (value) {
                  print('searched value $value');
                  onSearchTextChanged(value);
                  setState(() {});
                },
                onDone: (value) {
                  print('searched value $value');
                },
              ),
            ),
            //     new Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: new Card(
            //     child: new ListTile(
            //       leading: new Icon(Icons.search),
            //       title: new TextField(
            //         controller: controller,
            //         decoration: new InputDecoration(
            //             hintText: 'Search for existing Actions',
            //             border: InputBorder.none),
            //         onChanged: onSearchTextChanged,
            //       ),
            //       trailing: new IconButton(
            //         icon: new Icon(Icons.cancel),
            //         onPressed: () {
            //           controller.clear();
            //           onSearchTextChanged('');
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ),
          Expanded(
            child: _searchResult.length != 0 
                ? ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                       return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Card(
                         // color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _searchResult[index].title,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(_searchResult[index].type,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                                Text(_searchResult[index].usedby,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                                Text(_searchResult[index].lastused,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                              ],
                            ),
                          ),
                          margin: const EdgeInsets.all(0.0),
                          elevation: 2,
                        ),
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _actionDetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Card(
                         // color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _actionDetails[index].title,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(_actionDetails[index].type,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                                Text(_actionDetails[index].usedby,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                                Text(_actionDetails[index].lastused,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xFF797979))),
                              ],
                            ),
                          ),
                          margin: const EdgeInsets.all(0.0),
                          elevation: 2,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _actionDetails.forEach((userDetail) {
      if (userDetail.title.toLowerCase().contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}
