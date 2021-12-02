import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/select_items/item.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/snackbar.dart';

class MultiSelect extends StatefulWidget {
  final String navTitle;
  final SelectType type;
  final DataSourceType dataSourceType;
  final int maxSelectItemLimit;
  final selectedValues;
  final dataSource;
  final bool enableSelectAllOption;

  final Function<T>(T) onDoneClicked;

  MultiSelect(
      {Key? key,
      required this.navTitle,
      required this.type,
      required this.dataSourceType,
      required this.onDoneClicked,
      required this.selectedValues,
      required this.dataSource,
      required this.enableSelectAllOption,
      required this.maxSelectItemLimit})
      : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final Key _focusDetectorKey = UniqueKey();

  Icon actionIcon = Icon(Icons.search);

  late Widget appBarTitle;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _searchTextController =
      new TextEditingController();

  late Box<HiveCurrentUser> _currentUserBox;

  List<Item> _items = [];

  bool _isSearching = false;
  String _searchText = '';

  bool _isSelectAllSelected = false;

  @override
  void initState() {
    super.initState();
    appBarTitle = Text(widget.navTitle);

    switch (widget.dataSourceType) {
      case DataSourceType.country:
        List<HiveCountry> _countries = widget.dataSource as List<HiveCountry>;
        HiveCountry _selectedCountry = widget.selectedValues as HiveCountry;

        _countries.forEach((element) {
          if (element.id == _selectedCountry.id) {
            var country = Item(data: element, isSelected: true);
            _items.add(country);
          } else {
            var country = Item(data: element, isSelected: false);
            _items.add(country);
          }
        });

        break;
      case DataSourceType.countries:
        List<HiveCountry> _countries = widget.dataSource as List<HiveCountry>;

        List<HiveCountry> _selectedCountries =
            widget.selectedValues as List<HiveCountry>;
        _countries.forEach((element) {
          var country = Item(data: element, isSelected: false);
          _items.add(country);
        });

        _selectedCountries.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveCountry).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.languages:
        List<HiveLanguage> _languages = widget.dataSource as List<HiveLanguage>;

        _languages.forEach((element) {
          var language = Item(data: element, isSelected: false);
          _items.add(language);
        });

        List<HiveLanguage> _selectedLanguages =
            widget.selectedValues as List<HiveLanguage>;
        _selectedLanguages.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveLanguage).id == element.id);
          if (index > -1) {
            _items[index].isSelected = true;
          }
        });

        break;
      case DataSourceType.topics:
        List<HiveMaterialTopic> _topics =
            widget.dataSource as List<HiveMaterialTopic>;

        _topics.forEach((element) {
          var topic = Item(data: element, isSelected: false);
          _items.add(topic);
        });

        List<HiveMaterialTopic> _selectedTopics =
            widget.selectedValues as List<HiveMaterialTopic>;
        _selectedTopics.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveMaterialTopic).name == element.name);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.types:
        List<HiveMaterialType> _types =
            widget.dataSource as List<HiveMaterialType>;

        _types.forEach((element) {
          var type = Item(data: element, isSelected: false);
          _items.add(type);
        });

        List<HiveMaterialType> _selectedTypes =
            widget.selectedValues as List<HiveMaterialType>;
        _selectedTypes.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveMaterialType).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.evaluationCategory:
        List<HiveEvaluationCategory> _types =
            widget.dataSource as List<HiveEvaluationCategory>;

        _types.forEach((element) {
          var type = Item(data: element, isSelected: false);
          _items.add(type);
        });

        List<HiveEvaluationCategory> _selectedCateogries =
            widget.selectedValues as List<HiveEvaluationCategory>;
        _selectedCateogries.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveEvaluationCategory).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.groups:
        List<HiveGroup> _groups = widget.dataSource as List<HiveGroup>;

        _currentUserBox =
            Hive.box<HiveCurrentUser>(HiveDatabase.CURRENT_USER_BOX);
        final currentUserId = _currentUserBox.values.first.id;

        _groups.forEach((element) {
          if (element.isMe == true) {
            _items.add(Item(data: element, isSelected: false));
          } else {
            if (element.getMyRole(currentUserId) == GroupUser_Role.ADMIN ||
                element.getMyRole(currentUserId) == GroupUser_Role.TEACHER) {
              var type = Item(data: element, isSelected: false);
              _items.add(type);
            }
          }
        });

        List<HiveGroup> _selectedGroups =
            widget.selectedValues as List<HiveGroup>;

        _selectedGroups.forEach((element) {
          final index = _items
              .indexWhere((item) => (item.data as HiveGroup).id == element.id);
          _items[index].isSelected = true;
        });

        break;

      default:
    }

    _changeStatusOfSelectAllButton();
  }

  _MultiSelectState() {
    _searchTextController.addListener(() {
      if (_searchTextController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchTextController.text;
        });
      }
    });
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        widget.navTitle,
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchTextController.clear();
    });
  }

  Widget navigationSearchBar() {
    return IconButton(
      icon: actionIcon,
      onPressed: () {
        setState(
          () {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = Icon(Icons.close);
              this.appBarTitle = TextField(
                controller: _searchTextController,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: Strings.searchBarHint,
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              );
              _handleSearchStart();
            } else {
              this.actionIcon = Icon(Icons.search);
              this.appBarTitle = Text(widget.navTitle);
              _handleSearchEnd();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      key: _focusDetectorKey,
      onFocusLost: () {
        _sendSelectedValues();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
          title: appBarTitle,
          automaticallyImplyLeading: true,
          actions: [
            navigationSearchBar(),
          ],
        ),
        body: Column(
          children: [
            Visibility(
              child: InkWell(
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 15.w, top: 5.h),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                              height: 60.h,
                              width: MediaQuery.of(context).size.width - 88.0.w,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Strings.selectAll,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 60.w,
                          child: Icon(
                            (this._isSelectAllSelected == true)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: AppColors.selectedButtonBG,
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () => {
                        setState(() {
                          _isSelectAllSelected = !_isSelectAllSelected;
                          _updateStatus();
                        })
                      }),
              visible: widget.enableSelectAllOption,
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: _isSearching ? _searchListBuilder() : _listBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  _updateStatus() {
    _items.forEach((element) {
      element.isSelected = _isSelectAllSelected;
    });
  }

  _changeStatusOfSelectAllButton() {
    var _selectedItemsLenth =
        _items.where((element) => element.isSelected == true).toList().length;
    if (_selectedItemsLenth == _items.length) {
      _isSelectAllSelected = true;
    } else {
      _isSelectAllSelected = false;
    }
  }

  Widget _listBuilder() {
    return Container(
      child: Scrollbar(
        thickness: 5.sp,
        isAlwaysShown: false,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ItemList(_items[index], this);
          },
        ),
      ),
    );
  }

  _searchListBuilder() {
    if (_searchText.isEmpty) {
      return _listBuilder();
    } else {
      List<Item> _searchList = [];
      for (int i = 0; i < _items.length; i++) {
        if (_items[i]
            .data
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(
              Item(data: _items[i].data, isSelected: _items[i].isSelected));
        }
      }
      return ListView.builder(
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          return ItemList(_searchList[index], this);
        },
      );
    }
  }

  itemTapped(Item selectedItem) {
    if (widget.type == SelectType.single) {
      _singleSelectItemTapped(selectedItem);
    } else {
      _multiSelectItemTapped(selectedItem);
    }
  }

  void _singleSelectItemTapped(Item selectedItem) {
    final index =
        _items.indexWhere((element) => element.data.id == selectedItem.data.id);
    setState(() {
      _items[index].isSelected = !_items[index].isSelected;
    });

    widget.onDoneClicked(_items[index].data);
    Navigator.pop(context);
  }

  void _multiSelectItemTapped(Item selectedItem) {
    final index =
        _items.indexWhere((element) => element.data.id == selectedItem.data.id);

    if (widget.maxSelectItemLimit > 0) {
      var selectedItemCount =
          _items.where((element) => element.isSelected == true).length;

      if (_items[index].isSelected == true &&
          selectedItemCount == widget.maxSelectItemLimit) {
        setState(() {
          _items[index].isSelected = !_items[index].isSelected;
        });
        return;
      }

      if (selectedItemCount == widget.maxSelectItemLimit) {
        return StarfishSnackbar.showErrorMessage(
            context, 'Maximum $selectedItemCount items can be selected.');
      }
    }

    setState(() {
      _items[index].isSelected = !_items[index].isSelected;
    });
    _changeStatusOfSelectAllButton();
  }

  void _sendSelectedValues() {
    List<dynamic> selectedValues = [];
    _items.forEach((item) {
      if (item.isSelected == true) {
        selectedValues.add(item.data);
      }
    });
    widget.onDoneClicked(selectedValues);
  }
}

class ItemList extends StatelessWidget {
  final Item item;
  final _MultiSelectState obj;

  ItemList(this.item, this.obj);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 15.w),
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 60.h,
                          width: MediaQuery.of(context).size.width - 90.0.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${this.item.data.name}',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 60.w,
                      child: Icon(
                        (this.item.isSelected == true)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColors.selectedButtonBG,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () => {this.obj.itemTapped(this.item)}),
      elevation: 2,
    );
  }
}
