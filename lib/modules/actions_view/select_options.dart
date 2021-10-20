//@dart = 2.9
import 'package:flutter/material.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class SelectOptions extends StatefulWidget {
  const SelectOptions();
  @override
  _SelectOptionsState createState() =>
      _SelectOptionsState();
}

class _SelectOptionsState extends State<SelectOptions> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List selectedUsers = [];

 
  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshpage() async {
    setState(() {});
  }

  /**
   * Add/Remove Subscribed keyword
   */
  void onUserSelected(bool selected, uid) {
    if (selected == true) {
      setState(() {
        selectedUsers.add(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    //  appBar: appBarBack(context, Theme.of(context).primaryColor),
      body: RefreshIndicator(
        onRefresh: _refreshpage,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
             
              
            ],
          ),
        ),
      ),
    );
  }
}
